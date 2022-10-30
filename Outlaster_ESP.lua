local enabled = false
local highlights = {}

local function getItem()
    enabled = not enabled
    
    if enabled then
        printconsole("Searching...", 0, 255, 0)
        for _,v in pairs (workspace:GetDescendants()) do
            if (v.Name == ("ClickDetector") or v.Name == ("TouchInterest") or v.Name == ("TouchTransmitter")) and v.Parent and v.Parent.Parent and v.Parent.Parent.Name ~= game.Players.LocalPlayer.Name and not v:FindFirstAncestorOfClass("Accessory") then
                local instParent = nil;
    
                if (v.Parent:IsA("MeshPart")) then
                   instParent = v.Parent
                elseif (v.Parent.Parent:IsA("MeshPart")) then
                   instParent = v.Parent
                end
               
                if (v:FindFirstChild("Highlight")) then
                   instParent = nil
                end
    
                if (instParent) then
                   local highlight = Instance.new("Highlight", instParent)
                   highlight.Adornee = instParent
                   highlight.FillColor = Color3.fromRGB(255, 0, 0)
                   highlight.FillTransparency = 0.5
                   highlight.OutlineColor = Color3.fromRGB(125, 0, 0)
                   highlight.OutlineTransparency = 0.1
                   highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                   table.insert(highlights, highlight)
                end
            end
        end
        printconsole("Search Complete!", 0, 125, 0)
    elseif not enabled then
        printconsole("Removing Highlights...", 255, 0, 0)
        for _, highlight in pairs(highlights) do
            table.remove(highlights, table.find(highlights, highlight))
            highlight:Destroy()
        end
        printconsole("Highlights Removed!", 125, 0, 0)
    end
end

game:GetService("ContextActionService"):BindAction("Search", getItem, false, Enum.KeyCode.V)