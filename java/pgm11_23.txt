//
//   This file contains the Java code from Program 11.23 of
//   "Data Structures and Algorithms
//    with Object-Oriented Design Patterns in Java"
//   by Bruno R. Preiss.
//
//   Copyright (c) 1998 by Bruno R. Preiss, P.Eng.  All rights reserved.
//
//   http://www.pads.uwaterloo.ca/Bruno.Preiss/books/opus5/programs/pgm11_23.txt
//
public class Simulation
{
    PriorityQueue eventList = new LeftistHeap ();

    public void run (double timeLimit)
    {
	boolean serverBusy = false;
	int numberInQueue = 0;
	RandomVariable serviceTime = new ExponentialRV (100.);
	RandomVariable interArrivalTime =
	    new ExponentialRV (100.);
	eventList.enqueue (new Event (Event.arrival, 0));
	while (!eventList.isEmpty ())
	{
	    Event event = (Event) eventList.dequeueMin ();
	    double t = event.getTime ();
	    if (t > timeLimit)
		  { eventList.purge (); break; }
	    switch (event.getType ())
	    {
	    case Event.arrival:
		if (!serverBusy)
		{
		    serverBusy = true;
		    eventList.enqueue (new Event(Event.departure,
			t + serviceTime.nextDouble ()));
		}
		else
		    ++numberInQueue;
		eventList.enqueue (new Event (Event.arrival,
		    t + interArrivalTime.nextDouble ()));
		break;
	    case Event.departure:
		if (numberInQueue == 0)
		    serverBusy = false;
		else
		{
		    --numberInQueue;
		    eventList.enqueue (new Event(Event.departure,
			t + serviceTime.nextDouble ()));
		}
		break;
	    }
	}
    }
    // ...
}
