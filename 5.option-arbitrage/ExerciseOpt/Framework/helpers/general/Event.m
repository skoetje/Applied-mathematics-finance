classdef (ConstructOnLoad) Event < event.EventData
    properties
        EventData
    end

    methods
        function event = Event(data)
            event.EventData = data;
        end
    end
end
