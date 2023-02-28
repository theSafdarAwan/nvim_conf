----------------------------------------------------------------------
--                       Neovim Configuration                       --
---------------------------------------------------------------------
--               ____________________________
--              !\_________________________/!\
--              !!                         !! \
--              !!         /\_/\           !! \
--              !!        ( o.o )          !! !
--              !!         > ^ <           !! !
--              !!                         !! !
--              !!    press :q! to exit    !! !
--              !!                         !! !
--              !!                         !! !
--              !!_________________________!! |
--              !/_________________________\!/
--                 __\_________________/__/\
--                !_______________________!/
--                ________________________
--               /oooo  oooo  oooo  oooo /!
--              /ooooooooooooooooooooooo/ /
--             /ooooooooooooooooooooooo/ /
--            /oooo===============oooo/_/
--            ```````````````````````
----------------------------------------------------------------------
if vim.version().minor < 8 then
	vim.notify_once("[Config] Neovim 0.8 or higher is required.", vim.log.levels.WARNING)
	return
end

(function()
	require("safdar").default()
	require("safdar").setup()
end)()
