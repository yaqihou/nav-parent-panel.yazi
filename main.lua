--- @since 25.2.26

local nav_parent_panel = ya.sync(
   function(state, direction)
	  local parent = cx.active.parent

	  if not parent then
		 ya.notify({
			title = "Navigation",
			content = "No parent directory available",
			timeout = 2,
		 })
		 return
	  end

	  local files = parent.files
	  local current_idx = parent.cursor + 1

	  if #files <= 1 then
		 ya.notify({
			title = "Navigation",
			content = "No sibling directories available",
			timeout = 2,
		 })
		 return
	  end

	  local offset = direction == "prev" and -1 or direction == "next" and 1 or 0
	  if offset == 0 then
		 ya.notify({
			title = "Error",
			content = "Invalid direction: " .. tostring(direction),
			timeout = 2,
		 })
		 return
	  end

	  local next_idx = current_idx
	  local attempts = 0

	  while attempts < #files do
		 next_idx = next_idx + offset

		 if next_idx > #files then
			next_idx = 1
		 elseif next_idx < 1 then
			next_idx = #files
		 end

		 local file = files[next_idx]
		 if file and file.cha.is_dir then
			ya.emit("cd", { file.url })
			return
		 end

		 attempts = attempts + 1
	  end

	  ya.notify({
		 title = "Navigation",
		 content = "No directories found in parent folder",
		 timeout = 2,
	  })
   end
)

return {
   entry = function(self, job)
	  local direction = job.args[1]
	  if not direction then
		 ya.notify({
			title = "Error",
			content = "No direction specified. Use 'prev' or 'next'",
			timeout = 2,
		 })
		 return
	  end

	  nav_parent_panel(direction)
   end
}
