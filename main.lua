--- @since 25.2.26

local function get_parent_info()
   local parent = cx.active.parent

   if not parent then
	  ya.notify({
		 title = "Navigation",
		 content = "No parent directory available",
		 timeout = 2,
	  })
	  return nil
   end

   local files = parent.files
   local current_idx = parent.cursor + 1

   if #files <= 1 then
	  ya.notify({
		 title = "Navigation",
		 content = "No sibling directories available",
		 timeout = 2,
	  })
	  return nil
   end

   return files, current_idx
end

local function navigate_to_directory(file, message, quiet)
   ya.emit("cd", { file.url })
   if not quiet then
	  ya.notify({
		 title = "Navigation",
		 content = message .. file.name,
		 timeout = 1.5,
	  })
   end
end

local function no_directories_found()
   ya.notify({
	  title = "Navigation",
	  content = "No directories found in parent folder",
	  timeout = 2,
   })
end

local function navigate_sequential(files, current_idx, direction, quite)
   local offset = direction == "prev" and -1 or 1
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
		 navigate_to_directory(file, "Switched to: ", quite)
		 return
	  end

	  attempts = attempts + 1
   end

   no_directories_found()
end

local function navigate_edge(files, direction, quite)
   if direction == "first" then
	  for i = 1, #files do
		 local file = files[i]
		 if file and file.cha.is_dir then
			navigate_to_directory(file, "Switched to first directory: ", quite)
			return
		 end
	  end
   elseif direction == "last" then
	  for i = #files, 1, -1 do
		 local file = files[i]
		 if file and file.cha.is_dir then
			navigate_to_directory(file, "Switched to last directory: ", quite)
			return
		 end
	  end
   end

   no_directories_found()
end

local nav_parent_panel = ya.sync(
   function(state, direction)
	  local files, current_idx = get_parent_info()
	  if not files then return end

	  if direction ~= "prev" and direction ~= "next" then
		 ya.notify({
			title = "Error",
			content = "Invalid direction: " .. tostring(direction),
			timeout = 2,
		 })
		 return
	  end

	  navigate_sequential(files, current_idx, direction, (state.quite == nil) and true or state.quite)
   end
)

local nav_parent_edge = ya.sync(
   function(state, direction)
	  local files, current_idx = get_parent_info()
	  if not files then return end

	  if direction ~= "first" and direction ~= "last" then
		 ya.notify({
			title = "Error",
			content = "Invalid direction: " .. tostring(direction),
			timeout = 2,
		 })
		 return
	  end

	  navigate_edge(files, direction, (state.quite == nil) and true or state.quite)
   end
)

return {
   entry = function(_, job)
	  local direction = job.args[1]
	  if not direction then
		 ya.notify({
			title = "Error",
			content = "No direction specified. Use 'prev', 'next', 'first', or 'last'",
			timeout = 2,
		 })
		 return
	  end

	  if direction == "prev" or direction == "next" then
		 nav_parent_panel(direction)
	  elseif direction == "first" or direction == "last" then
		 nav_parent_edge(direction)
	  else
		 ya.notify({
			title = "Error",
			content = "Invalid direction: " .. direction,
			timeout = 2,
		 })
	  end
   end,
   setup = function(state, args)

	  state.quite = ((args.quite == nil) or args.quite) and true
	  
	  ya.dbg({
			title = "Setup",
			argsQuite = tostring(args.quite),
			stateQuite = tostring(state.quite)
	  })

   end
}
