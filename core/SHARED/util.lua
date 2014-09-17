function require (file)
	if type(file) == "string" then
		if fileExists(file) then
			local fileName = file
			local file = fileOpen(fileName, true)
			
			if fileGetSize(file) > 0 then
				local f, errmsg = loadstring(fileRead(file, fileGetSize(file)), fileName)
					if (f) then			
						local status, errmsg = pcall(f)
						
						if (not status) then
							error(errmsg, 0)
						end
						
						return true;
					else
						error(errmsg, 0)
					end
				else
					fileClose(file)
					error("Error @ 'require' [Got empty file!]", 2)
				end
		else
			error("Error @ 'require' [File not found!]", 2)
		end
	else
		error("Bad Argument @ 'require' [Expected file at Argument 1, got "..type(file).."]", 2)
	end
end

-- Multi Argument check
function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end