every 3.days do
  rake "import_foodpro"
end

every :reboot do
  rake "thinking_sphinx:start"
end

every 1.hour do
  rake "ts:rebuild"
end