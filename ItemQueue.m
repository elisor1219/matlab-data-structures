classdef ItemQueue < handle
    %TODO: Dynamic queue if no size is defined, aka using a dynamic array
    %TODO: Set type on properties
    properties %(Access = private)
        NumberOfItemsInQueue    %The number of items in the queue (Int--)
        MaxSizeOfQueue (1,1) double {mustBePositive} = Inf    %The max size of the current array (Int--)
        ElementsOfTheQueue      %The current elements in the queue (Array)
        
        PointerFirstItem = 1;      %Pointing on the first item in the queue.
        PointerLastItem = 0;       %Pointing on the last item in the queue. 
        isMaxSize = false;      %If user defined max size. (Boolean)
        
    end
    
    methods
        %Constructor
        function obj = ItemQueue(size)
            if nargin > 0
                if size <= 0
%                     errID = 'myComponent:inputError';
%                     msgtext = 'Size of the queue must be greater then 0, currently %d';
%                     A1 = size;
%                     ME = MException(errID, msgtext, A1);
%                     throw(ME);
                    error('Constructor:InputMustBeGreaterThenZero', 'Size of the queue must be greater then 0, currently %d', size)
                end
                obj.MaxSizeOfQueue = size;
                obj.isMaxSize = true;
                obj.ElementsOfTheQueue = zeros(1,size);
            end
            obj.NumberOfItemsInQueue = 0;
        end
        
        function enqueue(obj, itemToAdd)
            if obj.isFull
                error('Enqueue:Overflow', 'Overflow! No room left in the queue, it is full!')
            end
            obj.PointerLastItem = mod(obj.PointerLastItem, obj.MaxSizeOfQueue) + 1;
            obj.ElementsOfTheQueue(obj.PointerLastItem) = itemToAdd; 
            obj.NumberOfItemsInQueue = obj.NumberOfItemsInQueue + 1;
        end
        
        function removedItem = dequeue(obj)
            if obj.isEmpty
                error('Dequeue:Underflow', 'Underflow! No elements left in the queue, it is empty!')
            end
            removedItem = obj.ElementsOfTheQueue(obj.PointerFirstItem);
            obj.NumberOfItemsInQueue = obj.NumberOfItemsInQueue - 1;
            obj.ElementsOfTheQueue(obj.PointerFirstItem) = "";
            obj.PointerFirstItem = mod(obj.PointerFirstItem, obj.MaxSizeOfQueue) + 1;
            
        end
        
        function firstItem = peek(obj)
            if obj.isEmpty
                error('Underflow! No elements to see in the queue, it is empty!')
            end
            firstItem = obj.ElementsOfTheQueue(obj.PointerFirstItem);
        end
        
        function boolIsFull = isFull(obj)
            boolIsFull = obj.NumberOfItemsInQueue == obj.MaxSizeOfQueue;
        end
        
        function boolIsEmpty = isEmpty(obj)
            boolIsEmpty = obj.NumberOfItemsInQueue == 0;
        end
        
        
    end
    
    %Private methods
    methods (Access = private)
        
    end
end