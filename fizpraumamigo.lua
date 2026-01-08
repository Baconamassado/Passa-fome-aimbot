local Airflow = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/4lpaca-pin/Airflow/refs/heads/main/src/source.luau"))()

local a = false     
local c = nil       
local t = nil        

Airflow:Notify({
	Title = "Eae yuri passa fome rs",
	Content = "Script ta iniciando",
	Duration = 2,
})

local w = Airflow:Init({
	Name = "Passa fome aimbot",
	Keybind = "LeftAlt",
	Logo = "http://www.roblox.com/asset/?id=118752982916680",
	Highlight = Color3.fromRGB(163, 128, 216),
	Resizable = true,
	UnlockMouse = false,
	IconSize = 20,
})

local tab = w:DrawTab({
	Name = "Aimbot",
	Icon = "file"
})

tab:AddSection({
	Name = "Aimbot",
	Position = "left",
})

tab:AddToggle({
	Name = "Aimbot passa fome",
	Default = false,
	Callback = function(v)
        local ps = game:GetService("Players")
        local rs = game:GetService("RunService")
        local cam = workspace.CurrentCamera
        local lp = ps.LocalPlayer

        a = v

        local rp = RaycastParams.new()
        rp.FilterType = Enum.RaycastFilterType.Blacklist

        local function vis(ch)
            if not ch or not ch:FindFirstChild("Head") then return false end
            rp.FilterDescendantsInstances = {lp.Character, ch}

            local o = cam.CFrame.Position
            local d = ch.Head.Position - o

            local r = workspace:Raycast(o, d, rp)
            return r and r.Instance:IsDescendantOf(ch)
        end

        local function get()
            local p, m = nil, math.huge
            local s = cam.ViewportSize / 2

            for _, x in pairs(ps:GetPlayers()) do
                if x ~= lp and x.Character and x.Character:FindFirstChild("Head") then
                    local h = x.Character:FindFirstChildOfClass("Humanoid")
                    if h and h.Health > 0 and vis(x.Character) then
                        local v2, on = cam:WorldToViewportPoint(x.Character.Head.Position)
                        if on then
                            local d = (Vector2.new(v2.X, v2.Y) - s).Magnitude
                            if d < m then
                                m = d
                                p = x
                            end
                        end
                    end
                end
            end

            return p
        end

        if c then
            c:Disconnect()
            c = nil
        end

        if a then
            c = rs.RenderStepped:Connect(function()
                if t then
                    local ch = t.Character
                    local h = ch and ch:FindFirstChildOfClass("Humanoid")

                    if not ch or not h or h.Health <= 0 or not vis(ch) then
                        t = nil
                        return
                    end

                    cam.CFrame = CFrame.new(
                        cam.CFrame.Position,
                        ch.Head.Position
                    )
                else
                    t = get()
                end
            end)
        else
            t = nil
        end
	end
})

Airflow:Notify({
	Title = "Fiz na pressa",
	Content = "Não tem muitas funções mas é usavel eu acho",
	Duration = 5,
})
