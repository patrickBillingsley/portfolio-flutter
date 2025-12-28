# How I Avoided Mental Crisis While Migrating a Crisis Messaging System

What happens when a third-party dependency sunsets? You pivot.

What happens when every prior decision assumes that third-party dependency? You gripe and pivot.

What if that app connects people in times of mental crisis? What if there are over five years of production data to consider? What if not all users can update? What if there is no room for failure or downtime?

You worry, gripe, and—if you want to make sure this never happens again—you carefully plan your pivot.

- The application exists to connect people in times of mental crisis with a trusted support network in real time. In these scenarios failure can have irreversible real-world consequences. 
- A non-trivial subset of users were incapable of upgrading due to the age of their devices. This made backwards compatibility a central requirement. 
- Let’s take a look at how I stared into the void and returned to tell the tale.

## The Problem - A Dramatic Telling
(Exterior - Dusk)

API - “I don’t know when, but I’ll be leaving you soon.”

App - “What are you saying, Rodney? I’ve built everything on you.”

API - “Listen, Rebecca. You’re not the only one I’m letting down. I just can’t keep this up anymore.”

App - “What about the users? You’re just going to leave me to support them myself?”

API (Turning to sunset) - “Eventually.”

- Peer-to-Peer chats are the core functionality of the application and the feature was built from the ground up based on a third-party dependency. After several years of use the provider sunset the API meaning it would continue to work until it doesn’t. 
- Due to the sensitive nature of the application downtime and breaking changes were unacceptable.
- We had over five years of conversations that needed to carry forward and we needed to be able to rollback if something went wrong.

## The Sudden Valley Expansion

How do you fix a house sitting on a sinkhole? You build a house on another plot.
How do you avoid the problem in the future? Don’t build on another sinkhole.

It did not benefit the long term sustainability of the app to simply replace one point of failure with another, so I started from the ground up designing a bespoke in-house solution. This would not only accomplish the end goal but also increase the maintainability of critical functionality. The feature itself required a relatively simple solution. Everything else brought the complexity.

At a high level the approach is pretty straightforward.
Build an independent messaging solution.
Use a versioned API to delegate to the correct implementation.
Create a service class to synchronize the two.
Backfill existing conversations into the new solution.
Don’t break anything.
Having old and new solutions running in tandem meant I could easily roll back without data loss.
There were myriad things to consider. 
We had a white-listed database, so we needed to only affect our users.
Over five years of conversations would need to be migrated to the new solution.
Because of the laissez faire approach of the previous team there were duplicate users whose conversations would need to be consolidated in the migration process.

### Decoupling the Third-Party API or “From Its Cold Dead Fingers”
This feature was coupled tighter than my waistband after Thanksgiving dinner. The tag said “Forged in Mordor.” I digress.

Everything—and, I mean EVERYTHING—was built on this API. Naming conventions included the provider name. Every lookup was accompanied by unnecessary API requests. We couldn’t even look up messages for a chat in our own database without first fetching an identifier from the API. Just silliness.

Rather than race Sisyphus to push this boulder up a mountain in hell, I chose a path of peace. I vowed to touch the existing implementation as little as possible. I created a completely separate messaging ecosystem and it is beautiful. They say naming is one of the hardest things to do in programming. Please ready yourself for the splendor that is our new naming convention. We have two primary models, Chat and Message.

The only thing that changed in the old implementation was having it cue a compatibility service to handle creating its counterpart. Well, I also added more tests because I’m a gentleman programmer. 

Since the two implementations are completely independent of each other and synchronized, when the day comes that the API stops working we can burn the bridge that is the service class and never look back.

### API Versioning and Synchronization or “If It Can’t Be Fixed, Don’t Break It”
Like I tell my 8-year-old, “If you don’t want to break something, just don’t touch it.”

I left the original API intact as we already used a versioning scheme for our endpoints and created a new versioned API. I feature flagged the new messaging endpoints in the application which would provide control to rollback from the backend without having to release a new app version.

When a user sends a message to V1 the compatibility service creates a V2 message and vice versa. Yin and Yang.

Now the two can coexist without ever really knowing about each other. Its like if your kids actually stayed on their side of the car.

### Data Migration Strategy or “How I Won the War”
The thought of production failures keeps me up at night, so I do my damnedest to make sure I don’t have to think about them.

We’ve got over five years of conversations in our database and if you think that naming conventions were the only problem… This data was like a wad of Christmas lights. It was an exercise in futility. It was entropy incarnate.

I decided to be cutting edge and actually validate my data. Shocking, I know. There ended up being a lot of garbage. Duplicate chats, orphaned messages, and the like. A real sordid affair. To migrate the data I needed to filter out the noise. There’s a reason they call me Bose (puts on sunglasses).

Once I was able to account for the expected it was time to discover the unexpected, and I’m not talking about deploying to production. No! Let’s simulate that colossal failure instead.
1. I made a copy of the production database.
2. I ran the script on said database.
3. I saw how it broke or did not accomplish the goal.
4. I wrote a test.
5. I made that test pass.
6. Repeat.

I built out a Command Line Interface to track and report on the progress and outcomes. It kept tallies for all migrated entities and reported any data that was deemed invalid for manual inspection if necessary. Not only did this serve as a debugging tool while creating the script it also served to monitor the production migration. (High-fives self)

### Testing and Validation or “Suite Tooth”
Fool me once, shame on you. Fool me twice, I didn’t write a test.

I wrote tests at every level from the front end application to the API and migration scripts. There were no questions left unanswered, no concerns left unassuaged. 

I hear programmers gripe about writing tests all the time. I get it. I do the same thing because sometimes writing tests is harder than writing the actual feature, but nothing beats the warm cozy feeling of security when shipping a rigorously tested solution. You don’t think it works. You know it works.

Life is like a box of chocolates. A test suite helps you avoid the coconut ones.

### Deployment and Risk Mitigation or “Basket Sale at the Egg Store”
You should do whatever you can to ensure success, but you should also be prepared for failure.

With feature flags and the mirrored nature of the solution I could easily toggle the new version on and off. I even added app versioning to the feature flags so we could have incremental control should we need to push fixes. This would avoid the possibility of broken intermediate versions.

Before doing anything permanent on production I made a backup that in the worst case scenario we could revert to. Hope for the best. Plan for the worst.

Things ended up going very smoothly. I had already made all the mistakes on copies of production. Nevertheless, everything was set up to be completely reversible should things go sideways. Again, hope for the best. Plan for the worst.

## Outcome or “How Stella Got Her Groove Back”
Buddy, let me tell you all that preparation paid off. I rolled out new Android and iOS app versions as well as the server side changes with the feature flags toggled off. I backed up the database and ran the migration. Monitoring the process with the CLI validated success. I flipped the switch and sent it live. In the end users experienced uninterrupted service, backwards compatibility was maintained, order was restored to the land, and the guy got the girl. 

Ultimately, I was able to deliver a robust, thoroughly tested, backwards compatible solution with no downtime and no production failures. Not only did it fulfill the requirements, but it came with bonuses. The new solution was vastly more performant from adding pagination. Yes, the old solution was not paginated. Think about fetching five years of messages in one API request… keep thinking about it… about that long. The new solution is also extensible. While we did not support group chats it was a feature the client frequently discussed. I made sure that the new solution could easily support group chats for future functionality. Again, I’m a gentleman programmer.

This was a herculean task. So much more went into this than covered here, e.g., push notifications, websocket connections, deeplinks, emoji support. I could go on. There were few surprises along the way because I made sure I was intimately familiar with the old solution before coming up with a plan of attack. I sought outside opinions when needed and brainstormed with fellow developers to plot the right course. Then I executed with confidence knowing what lie ahead.

We started out shackled to a sinking ship. I managed to save our hand in exchange for a walkie-talkie. That connection will someday be severed, but we’ll be on dry land. 

## Final Thoughts or “An Open Letter To Myself”
Dear Me,

	I hope this letter finds you well. I assume it will as I cannot remember a reason for it to do otherwise. You’ll be pleased to know that we tend to encapsulate our third-party dependencies now. It has already paid off a few times. Significant reductions in refactor time because you really don’t have to refactor anything. You just snap on a new implementation. Interfaces are pretty cool.
	We still test all of our features. Yes, on the front end, too. We’ve learned a lot about writing testable code. I’ve got some cool things to show you.

	Anyways, keep at it,
		You