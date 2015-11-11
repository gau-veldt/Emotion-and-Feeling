Emotion and Feeling by Brian Jack begins here.

"This extension adds feelings to every person in the world. Uses the Plutchik model:
https://en.wikipedia.org/wiki/Contrasting_and_categorization_of_emotions#Plutchik.27s_wheel_of_emotions"

"Written by Brian Jack
Copyright (C) 2015 Brian Jack
Released under the terms of the Creative Commons 3.0 Attribution license:
https://creativecommons.org/licenses/by/3.0/"

Chapter 1 - The feeling

[TODO:
I don't yet utilize this table.
It will allow a game to set initial perceptions, provides real-valued mood/perception,
thus allowing fractional mood/perception changes.  The integral numbers now used
are rather course and don't allow much variation for incremental perception change.]

[NB: Z machine will severly limit max number of people.
When a game exceeds glulx will be required for its larger memory capabilities]

[Will handle table up to 256 people]
[Increase as needed for more people]
Use MAX_STATIC_DATA of 2097152.
Use ALLOC_CHUNK_SIZE of 65536.

[Max of 128 people]
[If more change to C*C where C is total characters in game]
[the reflexive entries (eg: Spiderman,Spiderman,...) can be considered the character's own mood]
Table of Character Perceptions
Who (a person)	Whom (a person)	Attain (real number)	Enmity (real number)	Desire (real number)	Novel (real number)
with 16384 blank rows

[NB: The above maximum number of people is the worst case where every person
in the game may have a perception of another. If this won't happen in practice in
a game (stationary NPCs that will never encounter other NPCs for instance) then
this number may be lowered.]

a feeling is a kind of thing.
a feeling is usually privately-named.
a feeling is usually not portable.
a feeling has a number called attainability.	[abandoment or loss vs. aquisition]
a feeling has a number called enmity.	[fear vs. hatred of an enemy or obstacle]
a feeling has a number called desirability.	[rejection vs. acceptance]
a feeling has a number called predictability.	[surprise vs. expectation]
every person carries a feeling.

querying player mood is an action applying to nothing.
understand "mood" as querying player mood.

report querying player mood (this is the showing the player mood rule):
	let qm_feel be the feeling of the player;
	say "You feel [qm_feel]."

rule for printing the name of a feeling (called F) (this is the feeling printing rule):
	let fa be the attainability of F;
	let fe be the enmity of F;
	let fd be the desirability of F;
	let fp be the predictability of F;
	let feels be a list of text;
	if fa is 0 and fe is 0 and fd is 0 and fp is 0:
		add "devoid of feeling"to feels;	
	if fa < -2:
		add "in despair" to feels;
	if fa is -2:
		add "sad" to feels;
	if fa is -1:
		add "pensive" to feels;
	if fa is 1:
		add "serene" to feels;
	if fa is 2:
		add "happy" to feels;
	if fa > 2:
		add "ecstatic" to feels;
	if fe < -2:
		add "terrorized" to feels;
	if fe is -2:
		add "fearful" to feels;
	if fe is -1:
		add "apprehensive" to feels;
	if fe is 1:
		add "annoyed" to feels;
	if fe is 2:
		add "angry" to feels;
	if fe > 2:
		add "enraged" to feels;
	if fd < -2:
		add "loathing" to feels;
	if fd is -2:
		add "disgusted" to feels;
	if fd is -1:
		add "bored" to feels;
	if fd is 1:
		add "accepting" to feels;
	if fd is 2:
		add "trusting" to feels;
	if fd > 2:
		add "admiring" to feels;
	if fp < -2:
		add "vigilant" to feels;
	if fp is -2:
		add "anticipating" to feels;
	if fp is -1:
		add "interested" to feels;
	if fp is 1:
		add "distracted" to feels;
	if fp is 2:
		add "surprised" to feels;
	if fp > 2:
		add "amazed" to feels;
	if fp <= -2 and fa >= 2:
		remove "anticipating" from feels, if present;
		remove "vigilant" from feels, if present;
		remove "happy" from feels, if present;
		remove "ecstatic" from feels, if present;
		add "optimistic" to feels;
	if  fa >= 2 and fd >= 2:
		remove "happy" from feels, if present;
		remove "ecstatic" from feels, if present;
		remove "trusting" from feels, if present;
		remove "admiring" from feels, if present;
		add "loving" to feels;
	if  fd >= 2 and fe <= -2:
		remove "trusting" from feels, if present;
		remove "admiring" from feels, if present;
		remove "fearful" from feels, if present;
		remove "terrorized" from feels, if present;
		add "submissive" to feels;
	if fe <= -2 and fp >= 2:
		remove "fearful" from feels, if present;
		remove "terrorized" from feels, if present;
		remove "surprised" from feels, if present;
		remove "amazed" from feels, if present;
		add "awed" to feels;
	if fp >= 2 and fa <= -2:
		remove "surprised" from feels, if present;
		remove "amazed" from feels, if present;
		remove "sad" from feels, if present;
		remove "in despair" from feels, if present;
		add "disapproving" to feels;
	if fa <= -2 and fd <= -2:
		remove "sad" from feels, if present;
		remove "in despair" from feels, if present;
		remove "disgusted" from feels, if present;
		remove "loathing" from feels, if present;
		add "remorseful" to feels;
	if fd <= -2 and fe >= 2:
		remove "disgusted" from feels, if present;
		remove "loathing" from feels, if present;
		remove "angry" from feels, if present;
		remove "enraged" from feels, if present;
		add "contemptuous" to feels;
	if fe >= 2 and fp <= -2:
		remove "angry" from feels, if present;
		remove "enraged" from feels, if present;
		remove "anticipating" from feels, if present;
		remove "vigilant" from feels, if present;
		add "aggressive" to feels;
	say "[feels]".

instead of dropping a feeling (this is the preventing feelings from being dropped rule):
	say "Although it would be nice to just drop unwanted feelings
		at the door, they simply don't work that way.".

instead of taking inventory (this is the hiding feelings from inventory rule):
	now all things carried by the player are marked for listing;
	now all feelings carried by the player are unmarked for listing;
	if the number of marked for listing things enclosed by the player is 0, say "You are empty-handed." instead; 
	say "You are carrying: [line break]"; 
	list the contents of the player, with newlines, indented,
		giving inventory information, including contents,
		with extra indentation, listing marked items only. 

instead of examining a feeling (this is the suggesting alternative to examining feelings rule):
	say "Try using 'mood' rather than 'examine'."

instead of searching a feeling (this is the suggesting alternative to searching feelings rule):
	say "The way you feel is the result of all past events up to,
		and including, now."

Chapter 2 - Accessing a Person's Feelings

Section 1 - Access the Person's Feeling

to decide which feeling is the feeling of (X - a person):
	let pfs be the list of feelings carried by X;
	let f be entry 1 of pfs;
	decide on f.

Section 2 - Modify the Person's Feeling (by Affect pair)

to alter the attainability affect of (X - a person) by (amt - a number):
	let affect be the feeling of X;
	now the attainability of affect is amt + the attainability of affect.

to alter the enmity affect of (X - a person) by (amt - a number):
	let affect be the feeling of X;
	now the enmity of affect is amt + the enmity of affect.

to alter the desirability affect of (X - a person) by (amt - a number):
	let affect be the feeling of X;
	now the desirability of affect is amt + the desirability of affect.

to alter the predictability affect of (X - a person) by (amt - a number):
	let affect be the feeling of X;
	now the predictability of affect is amt + the predictability of affect.

to set the attainability affect of (X - a person) to (amt - a number):
	let affect be the feeling of X;
	now the attainability of affect is amt.

to set the enmity affect of (X - a person) to (amt - a number):
	let affect be the feeling of X;
	now the enmity of affect is amt.

to set the desirability affect of (X - a person) to (amt - a number):
	let affect be the feeling of X;
	now the desirability of affect is amt.

to set the predictability affect of (X - a person) to (amt - a number):
	let affect be the feeling of X;
	now the predictability of affect is amt.

Section 3 - Modify the Person's Feeling (by Mood)

to raise the happiness of (X - a person):
	alter the attainability affect of X by 1.
to lower the happiness of (X - a person):
	alter the attainability affect of X by -1.
to raise the sadness of (X - a person):
	alter the attainability affect of X by -1.
to lower the sadness of (X - a person):
	alter the attainability affect of X by 1.

to raise the anger of (X - a person):
	alter the enmity affect of X by 1.
to lower the anger of (X - a person):
	alter the enmity affect of X by -1.
to raise the fearfulness of (X - a person):
	alter the enmity affect of X by -1.
to lower the fearfulness of (X - a person):
	alter the enmity affect of X by 1.

to raise the trusting of (X - a person) :
	alter the desirability affect of X by 1.
to lower the trusting of (X - a person) :
	alter the desirability affect of X by -1.
to raise the disgust of (X - a person) :
	alter the desirability affect of X by -1.
to lower the disgust of (X - a person) :
	alter the desirability affect of X by 1.

to raise the intrigue of (X - a person) :
	alter the predictability affect of X by 1.
to lower the intrigue of (X - a person) :
	alter the predictability affect of X by -1.
to raise the vigilance of (X - a person) :
	alter the predictability affect of X by -1.
to lower the vigilance of (X - a person) :
	alter the predictability affect of X by 1.

Section 4 - Querying a Person's Feeling

Definition: a person is despairing if the attainability of entry 1 of the list of feelings enclosed by him	<= -3.
Definition: a person is sad if the attainability of entry 1 of the list of feelings enclosed by him 	<= -2.
Definition: a person is pensive if the attainability of entry 1 of the list of feelings enclosed by him 	<= -1.
Definition: a person is serene if the attainability of entry 1 of the list of feelings enclosed by him	>= 1.
Definition: a person is happy if the attainability of entry 1 of the list of feelings enclosed by him	>= 2.
Definition: a person is joyful if the attainability of entry 1 of the list of feelings enclosed by him	>= 2.
Definition: a person is ecstatic if the attainability of entry 1 of the list of feelings enclosed by him	>= 3.

Definition: a person is terrorized if the enmity of entry 1 of the list of feelings enclosed by him 	<= -3.
Definition: a person is fearful if the enmity of entry 1 of the list of feelings enclosed by him 	<= -2.
Definition: a person is anxious if the enmity of entry 1 of the list of feelings enclosed by him 	<= -1.
Definition: a person is apprehensive if the enmity of entry 1 of the list of feelings enclosed by him 	<= -1.
Definition: a person is annoyed if the enmity of entry 1 of the list of feelings enclosed by him	>= 1.
Definition: a person is angry if the enmity of entry 1 of the list of feelings enclosed by him	>= 2.
Definition: a person is enraged if the enmity of entry 1 of the list of feelings enclosed by him	>= 3.

Definition: a person is loathing if the desirability of entry 1 of the list of feelings enclosed by him 	<= -3.
Definition: a person is disgusted if the desirability of entry 1 of the list of feelings enclosed by him 	<= -2.
Definition: a person is bored if the desirability of entry 1 of the list of feelings enclosed by him 	<= -1.
Definition: a person is accepting if the desirability of entry 1 of the list of feelings enclosed by him	>= 1.
Definition: a person is trusting if the desirability of entry 1 of the list of feelings enclosed by him	>= 2.
Definition: a person is admiring if the desirability of entry 1 of the list of feelings enclosed by him	>= 3.

Definition: a person is vigilant if the predictability of entry 1 of the list of feelings enclosed by him 	<= -3.
Definition: a person is anticipating if the predictability of entry 1 of the list of feelings enclosed by him 	<= -2.
Definition: a person is interested if the predictability of entry 1 of the list of feelings enclosed by him 	<= -1.
Definition: a person is distracted if the predictability of entry 1 of the list of feelings enclosed by him	>= 1.
Definition: a person is surprised if the predictability of entry 1 of the list of feelings enclosed by him	>= 2.
Definition: a person is amazed if the predictability of entry 1 of the list of feelings enclosed by him	>= 3.

Definition: a person is optimistic if he is anticipating and he is happy.
Definition: a person is loving if he is happy and he is trusting.
Definition: a person is submissive if he is trusting and he is fearful.
Definition: a person is awed if he is fearful and he is surprised.
Definition: a person is disapproving if he is surprised and he is sad.
Definition: a person is remorseful if he is sad and he is disgusted.
Definition: a person is contemptuous if he is disgusted and he is angry.
Definition: a person is aggressive if he is angry and he is anticipating.

Chapter 3 - Person-to-Person Feeling Matrix (Relations)

consequent despair relates various people to various people.
the verb to be in despair around means the consequent despair relation.
the verb to be causing despair in means the reversed consequent despair relation.

consequent sadness relates various people to various people.
the verb to be sad around means the consequent sadness relation.
the verb to be causing sadness in means the reversed consequent sadness relation.

consequent pensiveness relates various people to various people.
the verb to be pensive around means the consequent pensiveness relation.
the verb to be causing pensiveness in means the reversed consequent pensiveness relation.

consequent serenity relates various people to various people.
the verb to be serene around means the consequent serenity relation.
the verb to be causing serenity in means the reversed consequent serenity relation.

consequent joy relates various people to various people.
the verb to be joyful/happy around means the consequent joy relation.
the verb to be causing joy/happiness in means the reversed consequent joy relation.

consequent ecstasy relates various people to various people.
the verb to be ecstatic around means the consequent ecstasy relation.
the verb to be causing ecstasy in means the reversed consequent ecstasy relation.

consequent terror relates various people to various people.
the verb to be terrified around means the consequent  terror relation.
the verb to be causing terror in means the reversed consequent terror relation.

consequent fearfulness relates various people to various people.
the verb to be fearful around means the consequent fearfulness relation.
the verb to be causing fear in means the reversed consequent fearfulness relation.

consequent apprehension relates various people to various people.
the verb to be apprehensive around means the consequent apprehension relation.
the verb to be causing apprehension in means the reversed consequent apprehension relation.

consequent annoyance relates various people to various people.
the verb to be annoyed around means the consequent annoyance relation.
the verb to be causing annoyance in means the reversed consequent annoyance relation.

consequent anger relates various people to various people.
the verb to be angry around means the consequent anger relation.
the verb to be causing anger in means the reversed consequent anger relation.

consequent rage relates various people to various people.
the verb to be enraged around means the consequent rage relation.
the verb to be causing rage in means the reversed consequent rage relation.

consequent loathing relates various people to various people.
the verb to be loathing/hating around means the consequent loathing relation.
the verb to be causing loathing/hatred in means the reversed consequent loathing relation.

consequent disgust relates various people to various people.
the verb to be disgusted around means the consequent disgust relation.
the verb to be causing disgust in means the reversed consequent disgust relation.

consequent boredom relates various people to various people.
the verb to be bored around means the consequent boredom relation.
the verb to be causing boredom in means the reversed consequent boredom relation.

consequent acceptance relates various people to various people.
the verb to be accepting around means the consequent acceptance relation.
the verb to be causing acceptance in means the reversed consequent acceptance relation.

consequent trust relates various people to various people.
the verb to be trusting around means the consequent trust relation.
the verb to be causing trust in means the reversed consequent trust relation.

consequent admiration relates various people to various people.
the verb to be admiring around means the consequent admiration relation.
the verb to be causing admiration in means the reversed consequent admiration relation.

consequent interest relates various people to various people.
the verb to be interested around means the consequent interest relation.
the verb to be causing interest in means the reversed consequent interest relation.

consequent anticipation relates various people to various people.
the verb to be anticipating around means the consequent anticipation relation.
the verb to be causing anticipation in means the reversed consequent anticipation relation.

consequent vigilance relates various people to various people.
the verb to be vigilant around means the consequent vigilance relation.
the verb to be causing vigilance in means the reversed consequent vigilance relation.

consequent distraction relates various people to various people.
the verb to be distracted around means the consequent distraction relation.
the verb to be causing distraction in means the reversed consequent distraction relation.

consequent surprise relates various people to various people.
the verb to be surprised around means the consequent surprise relation.
the verb to be causing surprise in means the reversed consequent surprise relation.

consequent amazement relates various people to various people.
the verb to be amazed around means the consequent amazement relation.
the verb to be causing amazement in means the reversed consequent amazement relation.

consequent optimism relates various people to various people.
the verb to be optimistic around means the consequent optimism relation.
the verb to be causing optimism in means the reversed consequent optimism relation.

consequent loving relates various people to various people.
the verb to be loving around means the consequent loving relation.
the verb to be causing love in means the reversed consequent loving relation.

consequent submissiveness relates various people to various people.
the verb to be submissive around means the consequent submissiveness relation.
the verb to be causing submissiveness in means the reversed consequent submissiveness relation.

consequent awe relates various people to various people.
the verb to be awed around means the consequent awe relation.
the verb to be causing awe in means the reversed consequent awe relation.

consequent disapproval relates various people to various people.
the verb to be disapproving around means the consequent disapproval relation.
the verb to be causing disapproval in means the reversed consequent disapproval relation.

consequent remorse relates various people to various people.
the verb to be remorseful around means the consequent remorse relation.
the verb to be causing remorse in means the reversed consequent remorse relation.

consequent contempt relates various people to various people.
the verb to be contemptuous around means the consequent contempt relation.
the verb to be causing contempt in means the reversed consequent contempt relation.

consequent aggressiveness relates various people to various people.
the verb to be aggressive around means the consequent aggressiveness relation.
the verb to be causing aggression in means the reversed consequent aggressiveness relation.

Emotion and Feeling ends here.

---- DOCUMENTATION ----

Chapter: Preamble

This extension adds feelings to every person in the world.

Each person carries a feeling (which is cleverly kept off inventory listings) that may be changed in the story during play.
The player has a command called 'mood' to query the mood.  Of course the mood command is more useful
in multiple-character games where each character may feel differently.

Each personal feeling is independent from those of other people.
Computed adjectives allow querying an actor's emotional state in the story.
A clever script might create rulesets to modify a character's behavior (or possible behavior)
due to changes in the character's mood.

Chapter: Accessing and Modfiying a Person's Feelings

To access the personal affectual state of some person X:

	let affect be a feeling.
	now affect is the feeling of X.

Then the poles may be directly accessed in conditions or phrases:

	the attainablity of affect	[-3	despair		-- 0 -- 	ecstasy		3+]
	the enmity of affect		[-3	terror		-- 0 -- 	rage		3+]
	the desirability of affect	[-3	loathing		-- 0 -- 	admiration	3+]
	the predictability of affect	[-3	vigilance	-- 0 -- 	amazement	3+]

They are just numbers and thus can exceed the -3..3 range which will just saturate
the affect at whichever end of the pole is exceeded.  If the story implements a system
of incremental affect changes then the saturation would require more change
in the opposite direction to "undo" the affect change.

There are also friends such as:

	raise the <mood> of X;
	lower the <mood> of X;
	alter the <affect> affect of X by <number>;
	set the <affect> affect of X to <number>;

affect is one of: attainability,enmity,desirability,predictability.

mood is one of: happiness,sadness,anger,fearfulness,
trusting,disgust,intrigue or vigilance. 

These conveinece phrases are useful for eliminating repetitive code.

NB: Initial setting of player affect must occur in 'when play begins' rules due to
the fact that Inform 7 will not allow access to a person's carried feeling
in the context of initial game world declaration (similar to the reason why
now phrases are not permitted).

Querying a person's affect is easily done using the computed adjectives available
for that purpose.

Chapter: The Cross-Person Mood Matrix

The extension's most powerful feature lies in the various mood matrix relations.
Using these relations it becomes possible for A to hate B,  C to trust D,
D to fear A, A to love C,B to love A**, etc.

** That's correct, it's NOT symmetrical.

The emotional model is based on Plutchik's model:
https://en.wikipedia.org/wiki/Contrasting_and_categorization_of_emotions#Plutchik.27s_wheel_of_emotions

There are four basic poles: elation (called attainability in the extension's source), enmity, desire (desirablity in the extension source) and novelty
(predictability in the extension source), with each pole having a positive and negative end.  Each end has three degrees of strength: -3,-2,-1 for the
negative end, 0 for the neutral (void of emotion) and 1,2,3 for the positive end.

	Table of Basic Emotions:
	emotional pole	-	+
	elation	sadness	joy
	enmity	fear	anger
	desire	disgust	trust
	novelty	anticipation	surprise
	
These eight basic ends then merge in adjacent pairs to form eight secondary emotions:

	Table of Secondary Emotions:
	Secondary Emotion	1st primary	2nd primary
	optimism				anticipation		joy
	love					joy				trust
	submission				trust			fear
	awe						fear				surprise
	disapproval				surprise			sadness
	remorse					sadness			disgust
	contempt				disgust			anger
	aggressiveness			anger			anticipation

The basic emotions coupled with strengths gives 24 possibilies, with the 8 secondaries allowing a total of 32 emotional states.
The secondary emotions are detected (by the computed adjectives) when both constituent primaries are at strength 2 or higher
(thus matching Plutchik's specifications for them).

These 32 emotional states also become a relational mapping between any two people and is, of course, not symmetrical
(A might love B however B may well hate A's guts).

The verbage is kind of awkward (due to its pattern) though it is grammatically tolerable:

The forward relation indicates that A feels <emotion> about B.
Thus if B hurt A and made A sad then the story could then issue the phrase: now A is sad around B.

	A is <emotion> around B

The reversed relation indicates the B is the cause of A to feel <emotion> about B.
Thus following the above example it would be true that: B is causing sadness in A.

	B is causing <emotion> in A

The different strengths are separate relations and the extension is designed with the understanding that if a person feels a certain strength of emotion,
that person is understood to feel at least any lower strength of the same emotion (so in cases where someone is in despair, it is true that they are also at
least pensive, and at least sad).  If a story needs to differentiate to a specific strength a direct check of the affect value must be done rather than using
the adjectives, and relation setting phrases will need to include phrases to clear the lower strength levels when an emotion is promoted (eg: pensive to
sad, sad to grieving, apprehensive to fearful, etc.).

Due to the insistence of English to have irrelgularities and defy consistency in langauge patterns
there are different words for the emotion in the forward versus the reversed relations.

	Table of relational verbs:
	emotion	forward	reversed
	despair	X is in despair around Y	Y is causing despair in X
	sadness	X is sad around Y	Y is causing sadness in X
	pensiveness	X is pensive around Y	Y is causing pensiveness in X
	serenity	X is serene around Y	Y is causing serenity in X
	joy	X is joyful around Y	Y is causing joy in X
	ecstasy	X is ecstatic around Y	Y is causing ecstasy in X
	terror	X is terrified around Y	Y is causing terror in X
	fearfulness	X is fearful around Y	Y is causing fear in X
	apprehension	X is apprehensive around Y	Y is causing apprehension in X
	annoyance	X is annoyed around Y	Y is causing annoyance in X
	anger	X is angry around Y	Y is causing anger in X
	rage	X is enrged around Y	Y is causing rage in X
	loathing	X is loathing around Y	Y is causing loathing in X
	disgust	X is disgusted around Y	Y is causing disgust in X
	boredom	X is bored around Y	Y is causing boredom in X
	acceptance	X is accepting around Y	Y is causing acceptance in X
	trust	X is trusting around Y	Y is causing trust in X
	admiration	X is admiring around Y	Y is causing admiration in X
	interest	X is intersted around Y	Y is causing interest in X
	anticipation	X is anticipating around Y	Y is causing anticipation in X
	vigilance	X is vigilant around Y	Y is causing vigilance in X
	distraction	X is distracted around Y	Y is causing distraction in X
	surprise	X is surprised around Y	Y is causing surprise in X
	amazement	X is amazed around Y	Y is causing amazement in X
	optimism	X is optimistic around Y	Y is causing optimism in X
	loving	X is loving around Y	Y is causing love in X
	submissiveness	X is submissive around Y	Y is causing submission in X
	awe	X is awed around Y	Y is causing awe in X
	disapproval	X is disapproving around Y	Y is causing disapproval in X
	remorse	X is remorseful around Y	Y is causing remorse in X
	contempt	X is contemptuous around Y	Y is causing contempt in X
	aggressiveness	X is aggressive around Y	Y is causing aggression in X

Clever IF writers ought to be able to work wonders with this system.
