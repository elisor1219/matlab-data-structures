classdef ItemQueue < handle
    %TODO: Dynamic queue if no size is defined, aka using a dynamic array
    %TODO: Wrapp around the array
    properties %(Access = private)
        NumberOfItemsInQueue    %The number of items in the queue (Int--)
        MaxSizeOfQueue = Inf    %The max size of the current array (Int--)
        ElementsOfTheQueue      %The current elements in the queue (Array)
        
        PointerFirstItem = 1;       %Where we are in the array.
        PointerLastItem = 0;       %Where we are in the array. 
        isMaxSize = false;      %If user defined max size. (Boolean)
        
    end
    
    methods
        %Constructor
        function obj = ItemQueue(size)
            if nargin > 0
                if size <= 0
                    error('Size of the queue must be greater then 0, currently %d', size)
                end
                obj.MaxSizeOfQueue = size;
                obj.isMaxSize = true;
                obj.ElementsOfTheQueue = zeros(1,size);
            end
            obj.NumberOfItemsInQueue = 0;
        end
        
        function enqueue(obj, itemToAdd)
            if obj.isFull
                error('Overflow! No room left in the queue, it is full!')
            end
            obj.PointerLastItem = (obj.PointerLastItem + 1);
            obj.ElementsOfTheQueue(obj.PointerLastItem) = itemToAdd; 
        end
        
        function removedItem = dequeue(obj)
            if obj.isEmpty
                error('Underflow! No elements left in the queue, it is empty!')
            end
            removedItem = obj.ElementsOfTheQueue(obj.PointerFirstItem);
            obj.PointerFirstItem = obj.PointerFirstItem + 1;
        end
        
        function firstItem = peek(obj)
            if obj.isEmpty
                error('Underflow! No elements to see in the queue, it is empty!')
            end
            firstItem = obj.ElementsOfTheQueue(obj.PointerFirstItem);
        end
        
        function boolIsFull = isFull(obj)
           boolIsFull = obj.PointerFirstItem >= obj.MaxSizeOfQueue;
        end
        
        function boolIsEmpty = isEmpty(obj)
           boolIsEmpty = mod(obj.PointerFirstItem,obj.MaxSizeOfQueue) > mod(obj.PointerLastItem,obj.MaxSizeOfQueue);
        end
    end
end