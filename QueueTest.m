% Test ItemQueue
clc;clear
size = 3;
myQueue = ItemQueue(size);

% Preconditions
testCase = matlab.unittest.TestCase.forInteractiveUse;


%% Test 1: Is empty with no elements
assert(myQueue.isEmpty());

%% Test 2: Is not full with no elements
assert(~myQueue.isFull);

%% Test 3: Initializing a <= 0 ItemQueue
verifyError(testCase,@() ItemQueue(0), 'Constructor:InputMustBeGreaterThenZero');

% try
%     ItemQueue(0);
% catch ME
%     if strcmp(ME.identifier, 'Constructor:InputMustBeGreaterThenZero')
%         assert(true)
%     else
%         ME %#ok
%         assert(false)
%     end
% end

%% Test 4: Error on dequeueing empty queue
try
    myQueue.dequeue();
catch ME
    if strcmp(ME.identifier, 'Dequeue:Underflow')
        assert(true)
    else
        ME %#ok
        assert(false)
    end
end


%% Test X: Error on enqueueing full queue
%TODO: if no errors are thrown, this will automatically pass.
%TODO: Find a better way to evaluate this, this cant
%      be the right way.
try
    myQueue.enqueue(1);
catch ME
    if strcmp(ME.identifier, 'Enqueue:Overflow')
        assert(true)
    end
    ME %#ok
    assert(false)
end

%% Test 10: Testing error
myQueue.enqueue(1)
try
    myQueue.dequeue();
catch ME
    assert(ME.identifier == Dequeue:Underflow)
end