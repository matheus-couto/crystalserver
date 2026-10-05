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

#pragma once

#include <string>

/**
 * Crandoria: reload ONE script file while the server runs.
 *
 * Running a revscript file again is not enough: actions, talkactions, move
 * events, global events and spells refuse a second registration of the same
 * id ("duplicate"), so the old, buggy version would keep answering. Each
 * manager therefore drops what the file registered first, then the file runs
 * again. Creature events stay in place (players and monster types hold them)
 * and are reused through copyEvent(); an NPC type keeps its object and only
 * its info is reset, so NPCs on the map pick up the new dialog and shop.
 *
 * If the file fails to load, whatever it managed to register is dropped and the
 * previous events are put back, so the server stays exactly as it was.
 */
namespace ScriptReload {
	struct Result {
		bool ok = false;
		std::string message;
	};

	/**
	 * @param file Path relative to the server root, as the panel shows it:
	 * "data-crandoria/scripts/...", "data/scripts/...", "data-crandoria/npc/..."
	 * or a lib file. Anything else is refused.
	 */
	Result reloadFile(const std::string &file);
} // namespace ScriptReload
