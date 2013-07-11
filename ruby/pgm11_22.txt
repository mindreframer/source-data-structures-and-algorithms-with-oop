#
# This file contains the Ruby code from Program 11.22 of
# "Data Structures and Algorithms
# with Object-Oriented Design Patterns in Ruby"
# by Bruno R. Preiss.
#
# Copyright (c) 2004 by Bruno R. Preiss, P.Eng.  All rights reserved.
#
# http://www.brpreiss.com/books/opus8/programs/pgm11_22.txt
#
class Simulation

    def initialize
        @eventList = LeftistHeap.new
        @serverBusy = false
        @numberInQueue = 0
        @serviceTime = ExponentialRV.new(100.0)
        @interArrivalTime = ExponentialRV.new(100.0)
    end

    def run(timeLimit)
        @eventList.enqueue(Event.new(Event::ARRIVAL, 0))
        while not @eventList.empty?
            evt = @eventList.dequeueMin
            t = evt.time
            if t > timeLimit
                @eventList.purge
                break
	    end
	    case evt.category
	    when Event::ARRIVAL
                if not @serverBusy
                    @serverBusy = true
                    @eventList.enqueue(Event.new(
			Event::DEPARTURE,
			t + @serviceTime.next))
                else
                    @numberInQueue += 1
		end
                @eventList.enqueue(Event.new(Event::ARRIVAL,
		t + @interArrivalTime.next))
	    when Event::DEPARTURE
                if @numberInQueue == 0
                    @serverBusy = false
                else
                    @numberInQueue -= 1
                    @eventList.enqueue(
                        Event.new(Event::DEPARTURE,
                        t + @serviceTime.next))
		end
	    end
	end
    end

end
