////////////////////////////////////////////////////////////////////////
// Crystal Server - an opensource roleplaying game
////////////////////////////////////////////////////////////////////////
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
////////////////////////////////////////////////////////////////////////

#include "lua/scripts/script_reload.hpp"

#include "config/configmanager.hpp"
#include "creatures/combat/spells.hpp"
#include "creatures/npcs/npcs.hpp"
#include "lua/creature/actions.hpp"
#include "lua/creature/creatureevent.hpp"
#include "lua/creature/movement.hpp"
#include "lua/creature/talkaction.hpp"
#include "lua/global/globalevent.hpp"
#include "lua/scripts/script_binding.hpp"
#include "lua/scripts/scripts.hpp"

#include <filesystem>

namespace {
	struct Counts {
		size_t actions = 0;
		size_t talkActions = 0;
		size_t moveEvents = 0;
		size_t creatureEvents = 0;
		size_t globalEvents = 0;
		size_t spells = 0;
		size_t npcs = 0;

		size_t total() const {
			return actions + talkActions + moveEvents + creatureEvents + globalEvents + spells + npcs;
		}
	};

	/** Removes (undo != nullptr) or just counts the events of a file in every manager. */
	Counts sweep(const std::string &file, ScriptReloadUndo* undo) {
		Counts counts;
		counts.actions = g_actions().removeScriptFile(file, undo);
		counts.talkActions = g_talkActions().removeScriptFile(file, undo);
		counts.moveEvents = g_moveEvents().removeScriptFile(file, undo);
		counts.creatureEvents = g_creatureEvents().removeScriptFile(file, undo);
		counts.globalEvents = g_globalEvents().removeScriptFile(file, undo);
		counts.spells = g_spells().removeScriptFile(file, undo);
		counts.npcs = g_npcs().removeScriptFile(file, undo);
		return counts;
	}

	std::string describe(const Counts &counts) {
		std::string text;
		const auto add = [&text](size_t count, const char* name) {
			if (count == 0) {
				return;
			}
			if (!text.empty()) {
				text += ", ";
			}
			text += std::to_string(count) + " " + name;
		};
		add(counts.actions, "action");
		add(counts.talkActions, "talkaction");
		add(counts.moveEvents, "movement");
		add(counts.creatureEvents, "creatureevent");
		add(counts.globalEvents, "globalevent");
		add(counts.spells, "spell");
		add(counts.npcs, "npc");
		return text.empty() ? "nenhum evento (funcoes e tabelas atualizadas)" : text;
	}

	bool under(const std::string &file, const std::string &root, const char* folder) {
		const auto prefix = root + "/" + folder + "/";
		return !root.empty() && file.starts_with(prefix);
	}

	/** Refuses what cannot be reloaded on its own; empty when the file is fine. */
	std::string refuse(const std::string &file) {
		if (file.empty() || file.front() == '/' || file.find("..") != std::string::npos || file.find('\\') != std::string::npos || !file.ends_with(".lua")) {
			return "caminho invalido";
		}

		const auto &data = g_configManager().getString(DATA_DIRECTORY);
		const auto &core = g_configManager().getString(CORE_DIRECTORY);
		const bool scripts = under(file, data, "scripts") || under(file, core, "scripts");
		const bool npc = under(file, data, "npc");
		const bool lib = under(file, data, "lib") || under(file, core, "libs") || under(file, core, "npclib");
		if (!scripts && !npc && !lib) {
			return "so da para recarregar arquivos de scripts, npc e lib; monstros, eventos e o resto pedem restart";
		}
		// They register with no file of origin to drop first, so a reload would
		// make them fire twice.
		if (file.find("/eventcallbacks/") != std::string::npos) {
			return "event callbacks nao podem ser recarregados sem restart";
		}
		// Reloading the panel queue from inside its own onThink would drop the
		// event that is running.
		if (file.ends_with("/globalevent_panel_commands.lua")) {
			return "este e o script que executa o proprio reload; ele so muda com restart";
		}
		return {};
	}
} // namespace

namespace ScriptReload {
	Result reloadFile(const std::string &file) {
		if (const auto reason = refuse(file); !reason.empty()) {
			return { false, reason };
		}

		// Same form Scripts::loadScripts() gives the file, so the events it
		// registers are traced back to it exactly as at startup.
		const auto path = std::filesystem::current_path() / file;
		if (!std::filesystem::is_regular_file(path)) {
			return { false, "arquivo nao encontrado: " + file };
		}

		ScriptReloadUndo undo;
		const auto removed = sweep(file, &undo);

		auto &scriptInterface = g_scripts().getScriptInterface();
		if (scriptInterface.loadFile(path.string(), path.filename().string()) == -1) {
			const auto error = scriptInterface.getLastLuaError();
			// Drop whatever the file registered before it failed, then put the
			// previous version back, newest change first.
			ScriptReloadUndo partial;
			sweep(file, &partial);
			for (auto it = undo.rbegin(); it != undo.rend(); ++it) {
				(*it)();
			}
			g_logger().warn("[ScriptReload] {} nao recarregado, versao anterior mantida: {}", file, error);
			return { false, "erro ao carregar, a versao anterior continua valendo: " + error };
		}

		// Startup events ran at boot; most of them hook monster types and tables
		// the rest of the file relies on, so they run again for this file.
		size_t startups = 0;
		for (const auto &event : g_globalEvents().startupEventsFromFile(file)) {
			event->executeEvent();
			++startups;
		}

		const auto loaded = sweep(file, nullptr);
		auto message = "recarregado: " + describe(loaded);
		if (startups > 0) {
			message += "; onStartup executado " + std::to_string(startups) + "x";
		}
		if (removed.total() > loaded.total()) {
			message += " (antes eram " + std::to_string(removed.total()) + " eventos)";
		}
		g_logger().info("[ScriptReload] {} - {}", file, message);
		return { true, message };
	}
} // namespace ScriptReload
