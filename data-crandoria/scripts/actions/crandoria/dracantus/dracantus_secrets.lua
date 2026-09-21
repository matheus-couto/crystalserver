local dracantusSecret = Action()

local texto = [[
Os aventureiros de Dracantus foram os 
responsaveis por tracar o caminho ate 
as profundezas da ilha, mas tambem sao 
os que protegem a entrada.

Por sorte, alguns espioes encontraram 
a rota e agora podem abri-la e 
tranca-la novamente para que ninguem 
perceba nossa entrada.

Para acessar a passagem, voce deve 
encontrar a cabana que esconde a entrada.
Teremos um vigia de Crandoria que abrira 
a porta quando te vir chegando. Voce nao 
o vera, mas nao se preocupe. Basta que  
voce tente abrir a porta e estara la 
dentro.

Nao conte sobre isso para ninguem, ou 
eles descobrirao nosso segredo.
]]

function dracantusSecret.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.Quest.U11_02.TheFirstDragon.Progresso) >= 11 then
		player:showTextDialog(item, texto, false)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANGE, "Voce ainda nao tem capacidade de interpretar as escrituras.")
		return false
	end
	return false
end

dracantusSecret:id(48278)
dracantusSecret:register()