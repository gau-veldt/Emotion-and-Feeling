Version 1/151910 of In World Creation (for glulx only) by Brian Jack begins here.

"Provides in-world content creation and generates necessary source."

Book I - Settings

Book II - Low level I6 ops (glulx calls)

Book III - In-Game Extension Control and Associated Actions

Book IV - Extension Runtime Bookkeeping

[if an object is created we generate source to create it]
an object can be created or compiled. an object is normally compiled.
a room can be creatable or non-creatable. a room is normally non-creatable.
[if an object is edited we generate source to set the edits]
an object can be edited or unedited. an object is normally unedited.
there are 49 creatable rooms.

[what may be edited.]
modification is a kind.
The specification of modification is "Modifications tell the extention what attributes
or properties have been changed at runtime in order to generate the
appropriate modification source.".
modification has an object called target.

text-modification is a kind of modification.
text-modification has a text called change.
change-description is a kind of text-modification.
change-initialtext is a kind of text-modification.

[there's no way I know of to reflect attributes (adjectives) of an object
so I must use a textual attribute name and rely on the attr-modification
to tell the code generation to generate an attribute modification phrase.
(eg: someObject is <attr>.)

As a consequence the list of editable attributes is rather limited and one
can only reasonably expect the standard rules attributes to be editable since
it's impossible to know what future extensions might try to define as new
object attributes thus it's not possible to create a parser vocabulary to
understand them from this extension (since the parser needs to recognize
them in order to trigger an appropriate editing action/rule.]
attr-modification is a kind of modification.
attr-modification has a text called new-attribute.

exit-modification is a kind of modification.
exit-modification has a Direction called heading.
exit-modification has a Room called destination.

room-editing relates a room (called the target) to various modifications.
the verb to modify-the-room (he modifies-the-room) means the reversed room-editing relation.
the verb to be room-modified by means the room-editing relation.

thing-editing relates a thing (called the target) to various modifications.
the verb to modify-the-thing (he modifies-the-thing) means the reversed thing-editing relation.
the verb to be thing-modified by means the thing-editing relation.

Part  One - Set Autocreate

SettingAutocreateHelp is an action out of world.
Report SettingAutocreateHelp: say "Autocreate expects: always/ask/never.".
Understand "autocreate help/--" as SettingAutocreateHelp.

SettingAutocreateOn is an action out of world.
Report SettingAutocreateOn: say "Ok, rooms will be created when you travel in undefined directions.".
Understand "autocreate always/on" as SettingAutocreateOn.

SettingAutocreateOff is an action out of world.
Report SettingAutocreateOff: say "Ok, travel in undefined directions will now be handled by the story (no room creation).".
Understand "autocreate never/off" as SettingAutocreateOff.

SettingAutocreateAsk is an action out of world.
Report SettingAutocreateAsk: say "Ok, when you travel in undefined directions I will ask you whether or not to create a new room.".
Understand "autocreate ask/confirm" as SettingAutocreateAsk.

An iwc autocreate mode is a kind.
An iwc autocreate mode can be on, off, ask.
An iwc autocreate mode is usually ask.
the autocreate setting is an iwc autocreate mode.

Book V - Code Generation

To decide which text is codegen of (R - a Room) changed by (E - an exit-modification):
	decide on "[destination of E] is [heading of E] of [R].[line break]".

Book VI - Creation

To decide which room is a newly created room:
	decide on entry 1 of the list of creatable rooms.

This is the extending the map rule:
	follow determine map connection rule;
	if the room gone to is nothing:
		let do-create be true;
		if autocreate setting is ask:
			say "Ok to create a room in this direction? ";
			if player consents:
				now do-create is true;
			otherwise:
				now do-create is false;
		if do-create is true:
			if the number of creatable rooms > 0:
				let dir be the noun;
				let r be a newly created room;
				now r is non-creatable;
				now r is created;
				now the printed name of r is "New room [dir] of [room gone from]";
				change dir exit of the (room gone from) to r;
				change (opposite of dir) exit of r to the (room gone from);
				now the room gone to is r;
			otherwise:
				say "I have run out of spare rooms for creation.[line break]";
				say "It's time to generate code, copy to the source and recompile."

the extending the map rule is listed instead of the determine map connection rule in the check going rules.

Book VII - Initialization

when play begins:
	say "[bracket]World Based Creation is Active[close bracket]";
	say "[line break]Asking for help: 'How to Create [bracket]topic[close bracket]'";
	say "[line break](Omitting topic completely yields an overview).";
	now autocreate setting is ask.

In World Creation ends here.

---- DOCUMENTATION ----

Provides in-world content creation and generates necessary source.
Allows authors to create their world from the world's perspective rather than a tl;dr inform sourcefile.
An author can generate the source, copy and paste into the source at the desired location (part/section/chapter/etc), save, recompile then return to the world to continue design.

Chapter: Introducton and Motivation

Creation of large worlds can be a daunting task with reams of text needed to be entered to
weave together the network of rooms and directional links that comprise it.  For the visually-oriented
it's an absolute nightmare of bloodshot eyes starting at a wall of "TL;DR" Inform source text.

This is where In World Creation comes in.
Include the extension and create one room:
 
	"Your Story" by Some IF Author.
 
	Include In World Creation by Brian Jack.
 
	bootstrap is a room.
 
 Run this story and you are ready to do in-world creation.
 
 Section: Auto-create
 
 There are imperatives such as Create Room and similar friends but I found always typing the various
 creation commands to be a full stop on my thought process during design so a "go where you want
 the world to go" flow is also implemented.  By default the extension will ask if you really mean to create
 a room when taking an undefined direction.  Such confirmations are useful during story play sessions
 that are combinations of design and playtesting of previously designed content where it is possible
 that such a move might occur accidentally.  However in purely design sessions even the yes/no question
 can be a thought-breaker so it may be turned off in play with:
 
	Autocreate Always

The default behavior:

	Autocreate  Ask

Disable auto-create (without removing extension from source) which allows the normal handling of travelling
in undefined directions as per the story source.

	Autocreate Never

(The above three examples are in-game commands, not source file instructions.)
