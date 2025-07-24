vim.g.mapleader = " "
local ok, err = pcall(function()
    require("wukong.lazy_init")
    require("wukong.remap")
    require("wukong.set")

    vim.defer_fn(function ()
        require("wukong.colorscheme-utils").init()
    end, 100)
end)
if not ok then
    vim.notify("Error loading config: " .. err, vim.log.levels.ERROR)
end
