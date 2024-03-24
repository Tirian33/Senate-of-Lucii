extends Node
##					0			1			2			3			4				5		6/Force A   7/Force B	  8/Force C
var weights = [[25, 0, 25], [35, 0, 15], [15, 0, 35], [20,10,20], [15,20,15], [40, 0, 10], [60, 0, 0], [-10, 0, 50], [-0, 60, 0]]

## Don't worry abouts: Text for pop up box, current position
## GS: 0 - normal; 1 - win, 2 - Draw, 3 - Lose
##Weights: index of wieghts array
## Gamestate# , Weight#, Textbox Prompt, r_text, m_text, l_text, PathA, PathB, PathC, map
var scenes = [
	[0, 0, "Speaker: Enemy Troops are upon our border with EoS. War is highly probable. Shall we strike first?", "Yes", "", "No", 1, -1, 2, [-1,-1,-1,-1,1,1,1,1]],
	[0, 1, "Speaker: We have determined to strike the enemy first. \nSpeaker: Shall we attack their Mountains or their Farmlands?", "The Mountains", "", "The Farmlands", 3, -1, 85, [-1,-1,-1,-1,1,1,1,1]],
	[0, 0, "Speaker: To be safe let us deploy our capital's troops to the border.\nSpeaker: Where should we send them", "The Mountains", "", "The Farmlands", 51, -1, 52, [-1,-1,-1,-1,1,1,1,1]],
	[0, 0, "Speaker: Our preemptive strike allowed us to take their less fortified mountain base. \nSpeaker: Shall we order the western troops to defend or to launch another attack?", "Defend", "", "Attack", 4, -1, 49, [-1,-1,1,-1,0,1,1,1]],
	[0, 0, "Speaker: Since we have some leway let us send troops from the capital to the front lines. \nSpeaker: Shall we send them to our Mountains or Farmlands?", "Mountains", "", "Farmlands", 5, -1, 36, [-1, -1, 1, -1, 0, 1, 1, 1]], 
	[0, 1, "Speaker: The Eastern flank is being attacked. \nSpeaker: Shall we send support to it? Or shall we have our western forces unite in Eos's mountains?", "Support the East", "", "Meet forces in the West", 17, -1, 6, [-1, -1, 1, -1, 1, 1, 1, 0]],
	[0, 1, "Speaker: The troops have joined forces in the West. However, our East Flank has been routed. \nSpeaker: It is unlikely that the enemy troops will proceed to our encampment. Should we change focus to our terrirory or continue our offensive?", "Reclaim our Land", "", "Continue Offensive",7, -1, 14, [-1, -1, 2, 0, 0, -1, 1, 0]],
	[0, 3, "Speaker: We have reclaimed our Eastern lands. \nSpeaker: However, a plauge has broken out amongst our Western forces.\nSpeaker: We have lost half of our army stationed there. Shall they push forwards, retreat, or stay there?", "Push forwards", "Retreat", "Stay there", 11, 13, 9, [-1, -1, 3, 0, 0, 1, 0, 0]],
	[0, 6, "Speaker: It seems our Western forces have been decimated by this new plague. Shall we preposition for peace?", "Agree", "", "Disagree", -2, -1, -1, [-1,-1,3,0,0,1,0,0]],#force end
	[0, 5, "Speaker: An envoy from Eos has arrived, they request an armistance on account of the plauge outbreak. \nSpeaker: Reports from our Western forces testify that it truely is a great danager.\nSpeaker: Shall we accept this armistance?", "Accept", "", "Decline", -2, -1, 10, [-1, -1, 3, 0, 0, 1, 0, 0]],
	[0, 1, "Speaker: Eos has's forces used the peace talks to mobilize their armys forward!. \nSpeaker: Our West flank will is currntly being decimated by the plauge.\nSpeaker: Shall they push forwards or return home?", "Push Forwards", "", "Return home", 11, -1, 13, [0, -2, 3, 0, 0, 1, 0, 0]],
	[0, 1, "Speaker: Our Western troops weakned by the plauge where unable to capture the enemy encampent.\nSpeaker: However, the odds are high that the enemy has the plauge. \nSpeaker: Shall we advance onto their territory or accept their armistance proposition? ", "Continue the War", "", "Prepare for Plauge", 12, -1, -2, [0,-3, -4, 0, 0, 1, 0, 0]],
	[0, 6, "Speaker: We have claimed the enemy's Farmlands. \nSpeaker: Our Scouts have since confirmed that the plauge has striken the enemy encampment and our mountains.\nSpeaker: Any further advancement is impossible. Shall we declare this war over?", "Agree", "", "Deny", -3, -1, -1, [0, -4, -4, 1, -4, 0, 0, 0]],#force end
	[0, 7, "Speaker: It seems that we were unable to recall our troops from the Western front.\nSpeaker: amongst the few that returned the plauge was evident. \n If we continue this war we shall surely lose. Shall we continue this war?", "Continue the war", "", "Call off the war", -1, -1, -2, [0,-2, -4, 0,-4, 1,0,0]],#force end
	[0, 0, "Speaker: While costly, our forces were able to overtake the enemy encampment.\nSpeaker: Shall we continue the offensive or return focus to the enemy in our lands?", "Continue Offensive", "", "Deal with enemy in our lands", 15, -1, 22, [-1, 1,0,0,0,-1,1,0]],
	[0, 1, "Speaker: It seems our forces were unable to take the enemy capital, and were routed instead.\nSpeaker: The enemy now outnumbers us shall we sue for peace?", "Continue the War", "", "Sue for Peace", 16, -1, -4, [0,-1,0,0,0,-1,1,0]],
	[0, 6, "Speaker: Our forces were just barely able to reclaim our farmlands in the East.\nSpeaker: Since our troops will likely fall if we progress further shall we sue for peace?", "Sue for peace", "", "Continue the Offensive", -5,-1,-1, [0,0,0,-1,0,1,0,0]], #force end
	[0, 0, "Speaker: Our encamped forces were able to reach the farmlands in the East just in time.\nSpeaker: With their arrival we were able to successfully defeat the enemy.\nSpeaker: Shall we have our troops in the West consolidate or shall we have the Eastern forces advance?", "Consolidate the West", "", "Advance in the East", 18, -1, 29,[-1, -1, 1, 0, 1, 2, 0, 0]], 
	[0, 1, "Speaker: Our forces are now consilidated in the West. \nSpeaker: However, Eos's forces have consolidated in their encampment.\nSpeaker: Shall we assult the encampment immedinatly, or await the Eastern forces?", "Assult", "", "Await", 19, -1, 20, [0, -2, 2, 0, 0, 2, 0, 0]], 
	[0, 1, "Speaker: Our Western forces were unable to capture the enemy encampment.\nSpeaker: Following this we recived an envoy from Eos requesting peace. Shall we accept?", "Accept Peace", "", "Continue War", -5, -1, 21, [0, -1, 0, 0, 0, 2, 0, 0]],
	[0, 6, "Speaker: Our troops have surrounded the Eos encampment.\nSpeaker: In response Eos has formally surrendered.\nSpeaker: Shall we accept this surrender?", "Accept", "", "Continue the War", -8, -1, -1, [0, -2, 2, 2, 0, 0, 0, 0]], #force end
	[0, 2, "Speaker: We used the peace talks to train more troops, it seems Eos did the same.\nSpeaker: It seem that due to an overgarrison in the farmlands a plauge has appeared. \nSpeaker: Should they return to the encampment or press onwards?", "Return to the Encampment", "", "Press Onwards", 22, -1, 24, [0, -2, 0, 0, 0, 2, 1,0]],
	[0, 1, "Speaker: Our troops have returned to the encampment. However, many were lost due to the plauge.\nSpeaker: Now that a plauge has begun to ravage our farmlands shall we sue for peace? ", "Sue for Peace", "", "Continue the War", -2, -1, 23, [0, -2, 0, 0, 1, -4, 2, 0]],
	[0, 1, "Speaker: The plauge has entered our encampment.\nSpeaker: A continuation of the war effort will see the plauge reaching the capital shortly.\nSpeaker: As such we have no choice but to sue for peace, even at the cost of territory.", "Surrender Territory", "", "Death by Plauge", -4, -1, -6, [0, -2, 0, 0, 1, -4, 3, 0]], #choice end
	[0, 0, "Speaker: As our forces progressed many fell due to the plauge.\nSpeaker: Shall we have our forces in the West advance or shall our Eastern forces attack?", "Advance Western Forces", "", "Attack with Eastern Forces", 26, -1, 25, [0, -2, 0, 3, 0, -4, 1,0]],
	[0, 6, "Speaker: Our plauged forces were not able to do much against the enemy encampment.\nSpeaker: They did however, spread the plauge.\nSpeaker: Eos has in turn agreed to surrender land in exchange for the end of the war.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -3, -1, -1, [0, -3, 0, -4, 0, -4, 1,0]], #force end
	[0, 1, "Speaker: Our Western forces have entered Eos territory.\nSpeaker: However, while the Eastern forces were lost to the plauge.\nSpeaker: Eos has proposed peace, but demands that they keep their lands as is.\nSpeaker: Shall we accept?", "Accept Peace", "", "Continue the War", -5, -1, 27, [0, -2, 2, -4, 0, -4, 1,0]],
	[0, 0, "Speaker: During peace talks the plauge has spread westward into both Eos's and our encampments.\nSpeaker: Shall our forces attack the Eos encampment now or wait for the plauge to consume it?", "Take the encampment", "", "Wait for it to fall", -7, -1, 28, [0, -3, 2, -4, 0, -4, 3,0]],
	[0, 7, "Speaker: We have lost our encampment to the plauge.\nSpeaker: What remains is trying to prevent it from spreading to the capital.\nSpeaker: Shall we abandon this war and focus on controling the plauge?", "Continue the War", "", "Sue for Peace", -6, -1, -2, [0, -4, 3, -4, -4, -4, -4, 0]], #choice end
	[0, 1, "Speaker: Our Eastern forces have taken Eos's farmlands.\n Shall we attack their encampment now or wait for the Western forces to reorganize?", "Attack Now", "", "Await the Western Forces", 30, -1, 20, [0, -2, 1, 2, 1, 0, 0, 0]],
	[0, 0, "Speaker: Our Eastern forces were routed when attempting to take Eos's encampment.\nSpeaker: Eos has offered to ceed their mountains in exchange for peace.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -3, -1, 31, [0, -1, 1, 0, 1, 0, 0, 0]],
	[0, 6, "Speaker: After reorganizing our Western Forces were able to capture Eos's encampment.\nSpeaker: Eos has formally surrendered.\nSpeaker: Do we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0, 1, 0, 0, 0, 0, 0, 0]], #force end
	[0, 1, "Speaker: Our encamped forces were able to reclaim our farmlands.\nSpeaker: Eos has proposed peace in exchange for ceeding their farmlands.\n Do we accept? ", "Accept", "", "Continue the War", -3, -1, 33, [-1, 1, 0, 0, 0, 1, 0, 0]],
	[0, 0, "Speaker: Following the peace talks Eos reclaimed their encampment.\nSpeaker: Victory is unlikely. Shall we sue for peace?", "Sue for Peace", "", "Continue the War", -5, -1, 34],
	[0, 5, "Speaker: Our forces were unable to take the Eos encampment.\nSpeaker: Should we try and muster new forces now Eos will surely do the same.\nSpeaker: Suing for peace is our best option. All in favor?", "Sue for Peace", "", "Continue the War", -3, -1, 35, [0, -1, 0, 0, 0, 0, 0, 0]],
	[0, 6, "Speaker: After a great battle it has come to this.\nSpeaker: Eos has taken our encampment, and is offering a chance to formally surrender.\nSpeaker: Shall we accept it?", "Surrender", "", "Fight to the End", -9, -1, -10, [0, 0, 0, 0, -1, 0, -2, 1]], #choose end
	[0, 0, "Speaker: It seems sending forces to the Farmlands was a wise move.\nSpeaker: The additional troops were able to fend off an invasion from Eos.\nSpeaker: Let us press our advantage. Shall we continue forwards with our Western troops or our Eastern ones?", "Western", "", "Eastern", 37, -1, 48, [-1, -1, 1, 0, 0, 1, 1, 0]], 
	[0, 3, "Speaker: Our Western forces were unable to take the Eos encampment.\nSpeaker: Eos pre-empted our attack by sending additional forces to their encampment.\nSpeaker: What shall we do now?", "Surround encampment", "Sue for Peace", "Combine Forces", 38, 46, 47, [0, -1, 0, 0, 0, 1, 1, 0]],
	[0, 0, "Speaker: It took some time to surround Eos's encampment.\n During that time they appear to have trained more troops.\nSpeaker: Do we still wish to attack or do we wait for them to?", "Attack", "", "Wait", 34, -1, 39, [0, -2, 1, 1, 0, 0, 0, 0]],
	[0, 0, "Speaker: While waiting for Eos to respond a plauge has emerged in Eos's mountains.\nSpeaker: Reports from the field indicate that this plauge is very dangerous.\nSpeaker: Shall we Sue for peace?", "Sue for Peace", "", "Continue the War", -2, -1, 40, [0, -2, 3, 1, 0, 0, 0, 0]],
	[0, 1, "Speaker: Should the Western forces attack and spread the plauge?", "Attack", "", "Hold their Ground", 41, -1, 45, [0, -2, 3, 1, 0, 0, 0, 0]], 
	[0, 0, "Speaker: Our Western forces were defeated, but they spread the plauge.\nSpeaker: Shall we take Eos's encampment or wait for the plauge to weaken the enemy?", "Attack Encampment", "", "Defend", 42, -1, 43, [0, -3, 0, 1, 0,0,0,0]],
	[0, 6, "Speaker: Our forces captured Eos's encampment.\nSpeaker: However, they now are plauged.\nSpeaker: Fortunatly Eos has formally surrenderd. Shall we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0, 3, 0, 0, 0,0,0,0]], #force end
	[0, 2, "Speaker: Eos's has sued for peace. They will ceed their farmland.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -3, -1, 34, [0, -3, 0, 1, 0,0,0,0]],
	[0, 6, "Speaker: Eos's encampment has been lost to the plauge.\nSpeaker: Our forces were able to easily take control of it afterwards.\nSpeaker: Eos has formally surrendered. Shall we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0,3,0,0,0,0,0,0]], #force end
	[0, 6, "Speaker: Our Western forces were lost to the plauge, and Eos has routed our Eastern forces.\nSpeaker: Fortunatly Eos has sued for peace due to the plauge.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -2, -1, -1, [0, 0, -4, -1, 0,0,0,0]], #force end
	[0, 2, "Speaker: Eos is willing to go to peace, but will not ceed any territory.\nSpeaker: Do we accept?", "Accept", "", "Continue the War", -5, -1, 37, [0, -1, 0, 0, 0, 1, 1, 0]],
	[0, 6, "Speaker: Our combined forces were able to overtake Eos's encampment.\nSpeaker: Eos has formally surrendered. Do we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0, 1, 0, 0, 0,0,0,0]],#force end
	[0, 6, "Speaker: Upon our forces surrounding Eos's encampment, and seeing our resered forces.\nSpeaker: Eos has decided to formally surrender. Do we accept?", "Accept", "", "Continue the War", -7, -1, -1, [-1, -1, 1, 0, 0, 1, 1, 0]], #force end
	[0, 1, "Speaker: Our Western forces could not take Eos's encampment.\nSpeaker: Eos launched a surprise attack on our farmlands, and has captured them.\nSpeaker: Shall we reclaim the farmlands or hold the encampment?", "Reclaim Farmlands", "", "Hold encampment", 50, -1, 82, [-1, -1, 0, 0, 0, -1, 1, 1]  ],
	[0, 0, "Speaker: We have reclaimed our farmlands.\nSpeaker: It is time to deploy our capital's forces.\nSpeaker: Where should they be deployed to?", "Mountains", "", "Farmlands", 68, -1, 70, [-1, -1, 0, 0, 0, 1, 0, 1]],
	[0, 0, "Speaker: Eos has launched a surprise attack against our Farmlands.\nSpeaker: Shall we reclaim them or shall we attack their mountains?", "Reclaim Farmlands", "", "Attack Mountains", 87, -1, 95, [-1,-1,-1,0,2,-1,1,0]],#unfin? - ALT THREAD TEST FOR CONT
	[0, 0, "Speaker: Eos launchehd a surprise attack against our Farmlands.\nSpeaker: Fortunatly our additional forces were able to repel the attack.\nSpeaker: Shall we attack or defend our lands?", "Attack", "", "Defend", 54, -1, 53, [-1, -1, -1, 0, 1, 2, 1, 0]], 
	[0, 1, "Speaker: Eos claims that the attack on our borders was lead by insurgents.\nSpeaker: They are sueng for peace and willing to give money but not land.\nSpeaker:Do we accept or go offensive?", "Accept Peace", "", "Go Offensive", -11, -1, 54, [-1, -1, -1, 0, 1, 2, 1, 0]],
	[0, 1, "Speaker: It seems in thee wak of their surprise attack Eos has moved forces to their farmlands.\nSpeaker: Shall we combine the encampment forces with the Western forces?\nSpeaker: Or shall we go offensive with the Eastern forces?", "Combine Western", "", "Attack with Eastern", 55, -1,57, [0, -1, -1, -1, 1, 2, 1, 0] ],
	[0, 8, "Speaker: Now that our Western forces are combined what region should we attack?", "Mountains", "Both", "Farmlands", -1, 56, -1, [0, -1, -1, -1, 2, 2, 0, 0]], 
	[0, 6, "Speaker: Our forces have decimated Eos's. We now surround their encampment.\nSpeaker: Eos has formally surrenderd. Do we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0, -1, 2, 2, 0,0,0,0]], #force end
	[0, 1, "Speaker: Our foces have claimed Eos's Farmlands.\nSpeaker: Shall they attack Eos's encampment or should they hold their ground?", "Attack", "", "Defend", 58, -1, 59, [0, -1, -1, 2, 1, 0, 1, 0]],
	[0, 6, "Speaker: Our forces took heavy losses, but were able to take Eos's encampment.\nSpeaker: Eos has formally surrendered.\nSpeaker: Do we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0, 1, -1, 0, 1, 0, 0, 0]], #force end
	[0, 2, "Speaker: Eos has sued for peace. They will ceed territory.\nSpeaker: Do we accept?", "Accept", "", "Continue the War", -3, -1, 60, [0, -1, -1, 2, 1, 0, 1, 0]],
	[0, 0, "Speaker: Shall we combine the encampment forces with the Western forces before attacking?", "Combine", "", "Attack Now", 61, -1, 63, [0, -1, -1, 2, 1, 0, 1, 0]],
	[0, 0, "Speaker: While we combined our Western Forces, Our Eastern ones caught a plauge.\nSpeaker: Eos has trained additional forces in their encampment.\nSpeaker: Shall the Western forces advance or shall the Eastern forces attack Eos's encampment?", "Western Advance", "", "Eastern Attack", 64, -1, 62, [0, -2, 0, 3, 2, 0, 0, 0]],
	[0, 0, "Speaker: Our Eastern forces were routed while attacking.\nSpeaker: Fortunatly they seem to have spread the plauge.\nSpeaker: Shall our western forces Advance or shall we Sue for Peace?", "Sue for Peace", "", "Continue the War", -2, -1, 63, [0, -3, 0, -4, 2, 0, 0, 0] ],
	[0, 2, "Speaker: Our Western forces took position in Eos's mountains.\nSpeaker: Eos has sued for peace. They are willing to ceed terrirotry\nSpeaker: Do we accept?", "Accept", "", "Continue the War", -3, -1, 42, [0, -3, 2, -4, 0,0,0,0]], #jumps to prior end state
	[0, 0, "Speaker: Our forces have claimed Eos's mountains.\nSpeaker: Unfortunatly our Eastern forces have died to the plauge.\nSpeaker: Shall we atack or hold our ground?", "Attack", "", "Defend", 65, -1, 66, [0, -2, 2, -4, 0,0,0,0]],
	[0, 6, "Speaker: Our forces were routed while attacking Eos's encampment.\nSpeaker: Eos has sued for peace on grounds of a plauge.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -2, -1, -1, [0, -1, 0, -4, 0,0,0,0]], #force end
	[0, 0, "Speaker: The plauge has spread to Eos's encampment and our farmlands!\nSpeaker: Eos is willing to ceed some land for peace.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -3, -1, 67, [0, -3, 2, -4, 0,-4,0,0]],
	[0, 6, "Speaker: In Desperation Eos's troops attacked our Western Forces.\nSpeaker: Eos has followed this by formally surrendering.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0, -4, 3, -4, 0,-4,0,0]], #force end
	[0, 0, "Speaker: Our borders are once again secure.\nSpeaker: Now that the threat is gone shall we sue for peace or Advance onto Eos?", "Advance", "", "Sue for Peace", 69, -1, -5, [-1, -1, 0, 0, 1, 1, 0, 0]],
	[0, 0, "Speaker: Our forces now surround Eos's encampment.\nSpeaker: In response Eos has sent more troops to the encampment.\nSpeaker Shall we attack or hold a defensive position?", "Attack", "", "Defend", 34, -1, 39, [0, -2, 1, 1, 0, 0, 0, 0]], #jumps to prior board state
	[0, 0, "Speaker: Our forces have joined forces in our farmlands.\nSpeaker: Eos's forces have done the same in their encampment.\nSpeaker: Shall we sue for peace or Advance into Eos?", "Sue for Peace", "", "Continue the War", -5, -1, 71, [0, -2, 0, 0, 0, 2, 0, 0]],
	[0, 3, "Speaker: Our forces have claimed Eos's farmlands.\nSpeaker: However, the regions hygene is poor and a plauge is likely.\nSpeaker: Shall we attack the encampment, hold a defensive position, or fallback before the plauge affects our troops?", "Attack", "Defend", "Retreat", 72, 73,75, [0, -2, 0, 2, 0, 0, 0, 0]],
	[0, 6, "Speaker: Our forces were routed by Eos's encampment.\nSpeaker: We currently have no military. Fortunatly Eos is fearful of the plauge.\nSpeaker: Eos has proposed an armistance due to the plague. Shall we accept?", "Accept", "", "Continue the War", -2, -1, -1, [0, -1, 0, -4, 0, 0, 0, 0]], #force end
	[0, 1, "Speaker: Our Eastern Forces have become plagued.\nSpeaker: To prevent the plauge from spreading to us let us not recall them.\nSpeaker: Shall they continue to occupy Eos or shall they attack?", "Attack", "", "Defend", 72, -1, 74, [0, -2, 0, 3, 0, 0, 0, 0]],
	[0, 6, "Speaker: Our Eastern Forces were lost to the plauge.\nSpeaker: We no longer have military forces.\nSpeaker: Fortunatly Eos has proposed an armistance due to the plauge.\nSpeaker: Shall we accept?", "Accept", "", "Continue the War", -2, -1, -1, [0, -2, 0, -4, 0, 0, 0, 0]], #force end
	[0, 0, "Speaker: Our Eastern Forces were able to evacuate just in time.\nSpeaker: Eos's farmlands are plaugestriken, and it is likely to spread to ours.\nSpeaker: Where shall we move our forces?", "Mountains", "", "Encampment", 76, -1, 81, [0, -2, 0, -4, 0, 2, 0, 0] ],
	[0, 0, "Speaker: Our forces have now taken foot in our mountains.\nSpeaker: The plauge has reached our farmlands.\nSpeaker: Shall sue for an armistance?", "Sue for Armistance", "", "Continue the War", -2, -1, 77, [0, -2, 0, -4, 2, -4, 0, 0]],
	[0, 2, "Speaker: Our forces have advanced to Eos's mountains.\nSpeaker: Shall they attack Eos's encampment or enter a defensive?", "Attack", "", "Defend", 78, -1, 79, [0, -2, 2, -4, 0, -4, 0, 0]], 
	[0, 6, "Speaker: Our forces were routed while attacking Eos's encampment.\nSpeaker: We have no military. Fortuantaly Eos's encampment has been plauged.\nSpeaker: Eos has offered an armistance. Do we accept?", "Accept", "", "Continue the War", -2, -1, -1, [0, -3, 0, -4, 0, -4, 0, 0]],
	[0, 1, "Speaker: It seems the plauge has spread into Eos's encampment.\nSpeaker: Eos has sued for peace in exchange for ceeing some lands.\nSpeaker: Do we accept?", "Accept", "", "Continue the War", -3, -1, 80, [0, -3, 2, -4, 0, -4, 0, 0]],
	[0, 6, "Speaker: Our forces were easily able to overtake Eos's encampment.\nSpeaker: Eos has formally surrendered. Do we accept?", "Accept", "", "Continue the War", -7, -1, -1, [0, 3, 0, -4, 0, -4, 0, 0]], #force end
	[0, 0, "Speaker: Our forces have reached our encampment.\nSpeaker: Our only avenue of assult on Eos is through the mountains.\nSpeaker: Eos has proposed an armistance. Do we accept?", "Accept", "", "Continue the War", -2, -1, 76, [0, -2, 0, -4, 0, 0, 2, 0]], #call prior state path
	[0, 6, "Speaker: Eos's forces attacked our encampment, but were defeated.\nSpeaker: Eos sues for peace.\nSpeaker: Shall we accept?", "Accept", "", "Continue War", -5, -1, -1, [-1, -1, 0, 0, 0, 0, 1, 1]], #force end
	[0, 0, "Speaker: Our forces were able to reclaim our farmlands.\nSpeaker: Eos has sent more troops to their farmlands.\nSpeaker: Shall we focus on an assult in the West or on defense in the East?", "West Assult", "", "East Defense", 84, -1, -1, [0, 1, 1, 1, 2, 1, 0, 0]],
	[0, 6, "Speaker: Eos attacked our mountains region, but our forces routed them.\nSpeaker: Eos has sued for peace. They will ceed some land.\nSpeaker: Do we accept?", "Accept", "", "Continue War", -3,-1,-1, [0, -1, 0, -1, 2, 1, 0, 0]], #if time expand
	[0, 2, "Speaker: Our pre-emptive attack failed. It seems Eos was preparing the same.\n Eos was able to use this to claim our farmlands. However, they are greatly weakend\nSpeaker: Where should we send our Capital's troops?", "Mountains", "", "Farmlands", 86,-1,101, [-1, -1, -1, 0, 1, -1, 1, 1]],
	[0, 0, "Speaker: Our capital's forces have merged with our Western Forces.", "Reclaim Farmlands", "", "Attack Mountains", 87, -1, 95, [-1,-1,-1,0,2,-1,1,0]], #unfin? -TIED TO ALT
	[0, 2, "Speaker: Our encampment's forces were more than enough to reclaim our farmlands.\nSpeaker: Eos has moved forces to their farmlands.\nSpeaker: Shall we attack with our forces or stay defensive?", "Attack", "", "Defend", 89, -1, 88, [0, -1, -1, -1, 2, 1, 0, 0]],
	[0, 1, "Speaker: Eos has sued for peace. They claim insurgents launched the attack.\nSpeaker: They are not willing to ceed land, but will offer money.\nSpeaker: Shall we accept", "Accept", "", "Continue War", -11, -1, 89, [0, -1, -1, -1, 2, 1, 0, 0]],
	[0, 0, "Speaker: Shall we attack with our Western Forces or our Eastern ones?", "Western", "", "Eastern", 90, -1, 93, [0, -1, -1, -1, 2, 1, 0, 0]], 
	[0, 1, "Speaker: Our forces were able to take Eos's mountains with minimal damages.\nSpeaker: Shall we continue to their encampment or advance with our Eastern forces?", "Take encampment", "", "Take farmlands", 91, -1, 92, [0, -1, 2, -1, 0, 1, 0, 0]],
	[0, 6, "Speaker: After taking their encampment, Eos has formally surrendered.\nSpeaker: Shall we accept?", "Accept", "", "Continue War", -7, -1, -1, [0, 1, 0, -1, 0, 1, 0, 0]], #force end
	[0, 6, "Speaker: Our forces were able to take Eos's farmlands.\nSpeaker: Eos has formally surrendered. Shall we accept?", "Accept", "", "Continue War", -8, -1, -1, [0, -1, 2, 1, 0, 0, 0, 0] ],#force end
	[0, 7, "Speaker: Our Eastern Forces were able to take Eos's farmlands.\nSpeaker: Shall they proceed or shall they wait for the Western Forces?", "Attack the encampment", "", "Wait for Western", -1, -1, 94, [0, -1, -1, 1, 2, 0, 0, 0, 0]], #force choice, not end
	[0, 6, "Speaker: Our Western Forces were able to take Eos's mountains.\nSpeaker: Upon seeing their encampment surround Eos has formally surrendered.\nSpeaker: Shall we accept?", "Accept", "", "Continue War", -8, -1, -1, [0, -1, 2, 1, 0, 0, 0, 0]],#force end
	[0, 0, "Speaker: Our Western Forces were able to take Eos's mountains.\nSpeaker: Eos has proposed peace. They will return our land, we will return theirs.\nSpeaker: Do we accept?", "Accept", "", "Continue War", -5, -1, 96, [0, -1, 2, 0, 0, -1, 1, 0]],
	[0, 0, "Speaker: Eos used the peace talks to move forces to their encampment.\nSpeaker: Shall we attack the encampment or reclaim our lands?", "Attack encampment", "", "Reclaim", 97, -1, 100, [0, -2, 2, 0, 0, -1, 1, 0]],
	[0, 5, "Speaker: Our Western forces were routed while attacking Eos's encampment.\nSpeaker: Shall we reclaim our lands or surrender them?", "Reclaim", "", "Surrender them", 98, -1, -4, [0, -1, 0, 0, 0, -1, 1, 0]],
	[0, 6, "Speaker: Our Forces reclaimed our farmlands, but are exhaustsed.\nSpeaker: Eos has moved forces to their farmlands.\nSpeaker: Shall we sue for peace?", "Sue for Peace", "", "Continue War", -5, -1, 99, [0, 0, 0, -1, 0, 1, 0, 0]],
	[0, 1, "Speaker: Our Forces were defeated.\nSpeaker: Shall we surrender?", "Surrender", "", "Continue War", -9, -1, -10, [0, 0, 0, 0, 0, -1, 0, 0]], #choice end
	[0, 6, "Speaker: Our Forces reclaimed our farmlands.\nSpeaker: Eos has sued for peace. They will ceed land.\nSpeaker: Shall we accept?", "Accept", "", "Continue War", -3, -1, -1, [0, -2, 2, 0, 1, 0, 0]],#force end
	[0, 6, "Speaker: Our Forces were able to reclaim our farmlands.\nSpeaker: Upon examining the enemy, they appear to be insurgents of Eos.\nSpeaker: Eos has declared that they did not endorse this attack.\nSpeaker: Shall we continue war?", "Continue War", "", "Make Peace", -1, -1, -5, [-1, -1, -1, 0, 1, 1, 1, 0]], #force end, expand if time?
	
	#-indexes for game endings
	#-11 - Survived - Accepted payout from Eos
	[2, 0, "Survived. The Senate and Eos restored peace.\nEos promises to put down future insurgents faster.\nEos will continue to prosper as it has.", "", "", "", 0,0,0, [0,0,0,0,0,0,0,0]],
	#-10 - Lose - Capital raized
	[3, 0, "Military Loss. The Senate of Lucii's capital was destoryed.\nSenior Senator, your choices have lead to the absolute destruction of Lucii.", "","","",0, 0, 0, [0,0,0,0,0,0,0,0]],
	#-9 - Lose - Surrender
	[3, 0, "Military Surrender. The Senate of Lucii has surrenderd its nation.\nPerhaps this was the best that could be done. Perhaps it was not.\nAll that is certain is that this is not a positive outcome.", "","","",0, 0, 0, [0,0,0,0,0,0,0,0]],
	#-8 - Win - Eos Encampment overwhelmed
	[1, 0, "Victory! Upon the Lucii forces surrounding their encampment Eos surrendered\nWith such room to expand Lucii shall surly spread democracy to the far ends of the world!", "","","",0, 0, 0, [0,0,0,0,0,0,0,0]],
	#-7 - Win - Encampment taken, no Eos troops in capital
	[1, 0, "Victory! After taking Eos's encampment Eos has formally surrendered.\nWith such room to expand Lucii shall surly spread democracy to the far ends of the world!", "","","",0, 0, 0, [0,0,0,0,0,0,0,0]],
	#-6 - Lose - Plaugestriken
	[3, 0, "Plauge Loss. The Senate of Lucii ignored a looming plauge for too long.\nNow that it has hit your capital city your people are dying rapidly, and the enemy looms just beyond... ", "","","",0, 0, 0, [0,0,0,0,0,0,0,0]],
	#-5 - Survived - Neutral
	[2, 0, "Survived. You were not able to guide the Senate of Lucii to conquer Eos.\nHowever, you were able to prevent its fall.", "","","",0, 0, 0, [0,0,0,0,0,0,0,0]],
	#-4 - Lose - Territory lost
	[3, 0, "Military Loss. You have lost some of your lands to EoS.\nPerhaps you made a poor choice, or perhaps the odds did not favor you.", "", "", "", 0,0,0, [0,0,0,0,0,0,0,0]],
	#-3 - Win - Territorial expansion 
	[1, 0, "Victory! You were able to successfully guide the Senate of Lucii to expand its territory!\nWith this expansion surly Lucii will become an even greater nation!", "", "", "", 0, 0,0, [0,0,0,0,0,0,0,0] ],
	#-2 - Plauge = armistance
	[2, 0, "Survived. Peace was achieved out of fear of the plauge.\nThe war will undoubtibly resume in the future.", "", "", "", 0,0,0, [0,0,0,0,0,0,0,0]],
	#-1 YOU SHOULD NOT HAVE GOTTEN HERE
	[2, 0, "GBJ", "Leave", "Leave", "Leave", 0, 0, 0, [0,0,0,0,0,0,0,0]]
	
]

#debug
var force_vote = false

var rng = RandomNumberGenerator.new()
var current_state = 0
var left_to = 0
var mid_to = 0
var right_to = 0
var odds = [0, 0 ,0]
var last_outcome = [0,0,0,0,0]
var player_only_vote = false
var favor = 3

@onready var textbox = $Senate/Textbox
@onready var senate_preview = $Senate/Senate_Preview
@onready var right_button = $Senate/Option_Right
@onready var mid_button = $Senate/Option_Mid
@onready var left_button = $Senate/Option_Left
@onready var map = $Map
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func render_state(state_num:int):
	if state_num == -9999:
		get_tree().quit()
	elif scenes[state_num][0] != 0:
		update_prior_box()
		end_game(state_num)
	else:
		if state_num != 0:
			update_prior_box()
		else:
			left_button.tooltip_text = "Vote for and sway some opinion towards this option. Represented by blue."
			right_button.tooltip_text = "Vote for and sway some opinion towards this option. Represented by red."
		
		current_state = state_num
		map.next_state(scenes[current_state][9])
		
		odds = weights[scenes[current_state][1]].duplicate()
		match scenes[current_state][1]:
			1:
				senate_preview.texture = load("res://70-0-30.png")
				senate_preview.tooltip_text = "The Senate favors the left option."
			2:
				senate_preview.texture = load("res://30-0-70.png")
				senate_preview.tooltip_text = "The Senate favors the right option."
			3:
				senate_preview.texture = load("res://40-20-40.png")
				senate_preview.tooltip_text = "The Senate is not favorable to a compromise."
			4:
				senate_preview.texture = load("res://30-40-30.png")
				senate_preview.tooltip_text = "The Senate is favorable to a compromise."
			5:
				senate_preview.texture = load("res://80-0-20.png")
				senate_preview.tooltip_text = "The Senate STRONGLY favors the left option."
			6:
				senate_preview.texture = load("res://100-0-0.png")
				senate_preview.tooltip_text = "The Senate is unanimous for the left option."
			7:
				senate_preview.texture = load("res://0-0-100.png")
				senate_preview.tooltip_text = "The Senate is unanimous for the right option."
			8: 
				senate_preview.texture = load("res://1-48-1.png")
				senate_preview.tooltip_text = "The Senate STRONGLY favors a compromise option."
			_:
				senate_preview.texture = load("res://50-0-50.png")
				senate_preview.tooltip_text = "The Senate is equally split."
		
		
		left_button.text = scenes[current_state][3]
		left_to = scenes[current_state][6]
		mid_button.text = scenes[current_state][4]
		mid_to = scenes[current_state][7]
		right_button.text = scenes[current_state][5]
		right_to = scenes[current_state][8]
		
		if mid_to == -1:
			mid_button.hide()
		else:
			mid_button.show()
		
		textbox.add_text(scenes[current_state][2])
	
func end_game(win_state:int):
	textbox.add_text(scenes[win_state][2])
	player_only_vote = true
	left_to = 0
	left_button.text = "Play Again"
	left_button.tooltip_text = "Play Again"
	right_to = -9999
	right_button.text = "Quit Game"
	right_button.tooltip_text = "Quit Game"
	senate_preview.texture = load("res://Player-choice.png")
	senate_preview.tooltip_text = "This is your choice. The Senate will not weigh in."
	
	
func update_prior_box():
	var message = "Results of prior vote: \n"
	message = message + "You voted in favor of: " + str(scenes[current_state][last_outcome[3]]) + ".\n"
	if last_outcome[3] != (last_outcome[4] + 3):
		message = message + "However, the majority did not have the same opinion.\n"
	message = message + str(last_outcome[0]) + " in favor of " + scenes[current_state][3] + ".\n"
	if mid_to != -1:
		message = message + str(last_outcome[1]) + " in favor of " + scenes[current_state][4] + ".\n"
	message = message + str(last_outcome[2]) + " in favor of " + scenes[current_state][5] + ".\n"
	
	textbox.add_vote_result(message)
	

func _on_option_selected(pos:int):
	
	if force_vote:
		match pos:
			0:
				last_outcome = [51,0,0,pos+3,0]
				render_state(left_to)
			1:
				last_outcome = [0,51,0,pos+3,1]
				render_state(mid_to)
			2:
				last_outcome = [0,0,51,pos+3,2]
				render_state(right_to)
	else:
		
		if player_only_vote:
			if pos == 0:
				player_only_vote = false
				current_state = 0
				last_outcome = [0,0,0,0,0]
				textbox.restart()
				render_state(0)
			else:
				get_tree().quit()
		else:
			var vote0 = 0
			var vote1 = 0
			var vote2 = 0
			
			##odds 3 choices
			if odds[1] != 0:
				match pos:
					0:
						odds[0] += 10
						odds[1] -= 5
						odds[2] -= 5
						vote0 +=1
					1:
						odds[1] += 10
						odds[0] -= 5
						odds[2] -= 5
						vote1 +=1
					2:
						odds[2] += 10
						odds[1] -= 5
						odds[0] -= 5
						vote2 +=1
				
				if odds[1] >= 50:
					var rand_votes = rng.randi_range(1,10)
					var voted_left = rng.randi_range(1,9)
					vote2 += rand_votes - voted_left
					vote1 += 50 - rand_votes
					vote0 += voted_left 
				else:
					for senator in range(50):
						var voted = rng.randi_range(1,50)
						if voted <= odds[0]:
							vote0 +=1
						elif voted <= (odds[0] + odds[1]):
							vote1 +=1
						else:
							vote2 +=1
					
				last_outcome = [vote0, vote1, vote2, pos+3, 0]
				
				if vote0 > vote1 and vote0 > vote2:
					last_outcome[4] = 0
					render_state(left_to)
				elif vote1 > vote2:
					last_outcome[4] = 1
					render_state(mid_to)
				else:
					last_outcome[4] = 2
					render_state(right_to)
						
			else:
				##pos is 0 or 2
				if pos == 0:
					odds[0] += 10
					vote0 += 1
				else:
					odds[0] -= 10
					vote2 +=1
				
				for senator in range(50):
					var voted = rng.randi_range(1,50)
					if voted <= odds[0]:
						vote0 +=1
					else:
						vote2 +=1
				
				last_outcome = [vote0, 0, vote2, pos+3, 0]
				
				if vote0 > vote2:
					last_outcome[4] = 0
					render_state(left_to)
				else:
					last_outcome[4] = 2
					render_state(right_to)
		
		
		


