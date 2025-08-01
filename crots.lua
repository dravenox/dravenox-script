local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local WEBHOOK_URL = "https://discord.com/api/webhooks/1396276889538134077/F_7A2kiwaI1mJNB8_leWB4PnJEJcpzYV3zOJDl_4vYQqkaSaW-ykJFKz3eM-tIc06JLl"
local request = (syn and syn.request) or (http and http.request) or request or http_request

local function getPetImage(petName)
	local baseUrl = "https://static.wikia.nocookie.net/growagarden/images/"
	local petUrls = {
		['Parasaurolophus'] = "3/38/ParasaurolophusPet.png",
		['Dog'] = "2/29/DogPet.png",
		['Golden Lab'] = "f/f3/GoldenLabPet.png",
		['Bunny'] = "6/6b/BunnyPet.png",
		['Cat'] = "a/a0/CatPet.png",
		['Hamster'] = "1/1f/HamsterPet.png",
		['Rabbit'] = "e/e4/RabbitPet.png",
		['Turtle'] = "5/5a/TurtlePet.png",
		['Snake'] = "7/7c/SnakePet.png",
		['Lizard'] = "9/9b/LizardPet.png",
		['Frog'] = "2/2c/FrogPet.png",
		['Chicken'] = "4/4e/ChickenPet.png",
		['Duck'] = "8/8f/DuckPet.png",
		['Goose'] = "1/1a/GoosePet.png",
		['Pig'] = "3/3d/PigPet.png",
		['Cow'] = "7/7e/CowPet.png",
		['Horse'] = "5/5b/HorsePet.png",
		['Sheep'] = "9/9c/SheepPet.png",
		['Goat'] = "2/2a/GoatPet.png"
	}
	
	if petUrls[petName] then
		return baseUrl .. petUrls[petName] .. "/revision/latest"
	else
		return "https://cdn.discordapp.com/attachments/1276225419678585086/1400983567684599950/798f976405c8eceea5c970a5a0278361.jpg?ex=688e9f1f&is=688d4d9f&hm=dd8cf6bf64e7b38a8b8e31ff9bbeb1e17df53f749154369479455fc3f96914b9&"
	end
end

local activeEggs = {}
local hatchEvents = {}
local processedPets = {}
local existingPets = {}
local sendQueue = {}
local sending = false

local function Capitalize(str)
	return (str:gsub("(%a)(%w*)", function(a,b)
		return a:upper() .. b:lower()
	end))
end

local function processQueue()
	if sending or #sendQueue == 0 then return end
	sending = true

	while #sendQueue > 0 do
		local data = table.remove(sendQueue, 1)

		if request then
			pcall(function()
				request({
					Url = WEBHOOK_URL,
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body = HttpService:JSONEncode({ embeds = {data} })
				})
			end)
		end

		wait(1.5)
	end

	sending = false
end

spawn(function()
	wait(2)
	pcall(function()
		local playerWorkspace = workspace:FindFirstChild(player.Name)
		if playerWorkspace then
			for _, child in pairs(playerWorkspace:GetChildren()) do
				if child:IsA("Model") and child.Name:find("%[.*KG%]") then
					local petId = child.Name .. "_" .. tostring(child:GetDebugId())
					existingPets[petId] = true
				end
			end
		end
	end)
end)

spawn(function()
	while wait(0.1) do
		pcall(function()
			if workspace:FindFirstChild("Visuals") then
				for _, child in pairs(workspace.Visuals:GetChildren()) do
					local name = child.Name:lower()
					if name:find("egg") and not name:find("eggpoof") and not name:find("eggexplode") then
						if not activeEggs[child.Name] then
							activeEggs[child.Name] = {
								name = child.Name,
								startTime = tick()
							}
						end
					elseif name:find("eggexplode") then
						table.insert(hatchEvents, {
							time = tick(),
							processed = false
						})
					end
				end
				
				for eggName, _ in pairs(activeEggs) do
					local exists = false
					for _, child in pairs(workspace.Visuals:GetChildren()) do
						if child.Name == eggName then
							exists = true
							break
						end
					end
					if not exists then
						activeEggs[eggName] = nil
					end
				end
			end
		end)
	end
end)

spawn(function()
	while wait(0.3) do
		pcall(function()
			local playerWorkspace = workspace:FindFirstChild(player.Name)
			if playerWorkspace then
				for _, child in pairs(playerWorkspace:GetChildren()) do
					if child:IsA("Model") and child.Name:find("%[.*KG%]") then
						local petFullName = child.Name
						local petId = petFullName .. "_" .. tostring(child:GetDebugId())
						
						if not existingPets[petId] and not processedPets[petId] then
							local recentHatchTime = nil
							for i = #hatchEvents, 1, -1 do
								local hatchEvent = hatchEvents[i]
								if not hatchEvent.processed and tick() - hatchEvent.time <= 8 then
									recentHatchTime = hatchEvent.time
									hatchEvent.processed = true
									break
								end
							end
							
							if recentHatchTime then
								processedPets[petId] = true
								existingPets[petId] = true
								
								local petNameRaw = child.Name:split("[")[1]:gsub("%s+$", "")
								local petName = Capitalize(petNameRaw)
								local weight = child.Name:match("%[(.-KG)%]") or "??KG"
								local age = child.Name:match("Age (%d+)") or "??"
								local bonusText = ""

								if tonumber(age) and tonumber(age) > 1 then
									bonusText = string.format("\nOstrich Given : **%s Age!**", age)
								end

								local petImage = getPetImage(petName)
								
								local eggName = "an Egg"
								for name, data in pairs(activeEggs) do
									eggName = name
									break
								end

								local embed = {
									title = "`SatanLogs`",
									description = string.format("-# SatanStore hatched a **%s** and got **%s** (%s)%s", eggName, petName, weight, bonusText),
									color = 0x00FF00,
									thumbnail = { url = petImage }
								}

								table.insert(sendQueue, embed)
								spawn(processQueue)
							end
						end
					end
				end
			end
		end)
	end
end)

spawn(function()
	while wait(30) do
		pcall(function()
			for i = #hatchEvents, 1, -1 do
				if tick() - hatchEvents[i].time > 15 then
					table.remove(hatchEvents, i)
				end
			end
			
			local playerWorkspace = workspace:FindFirstChild(player.Name)
			if playerWorkspace then
				local currentPets = {}
				for _, child in pairs(playerWorkspace:GetChildren()) do
					if child:IsA("Model") and child.Name:find("%[.*KG%]") then
						local petId = child.Name .. "_" .. tostring(child:GetDebugId())
						currentPets[petId] = true
					end
				end
				
				for petId, _ in pairs(processedPets) do
					if not currentPets[petId] then
						processedPets[petId] = nil
					end
				end
				
				for petId, _ in pairs(existingPets) do
					if not currentPets[petId] then
						existingPets[petId] = nil
					end
				end
			end
		end)
	end
end)
