
* Project code

clear all
set more off


** import delimited "/Users/ishika/Desktop/Econometrics/Final Project/ATP.csv", varnames(1) clear
** gen female = 0
 
** import delimited "/Users/ishika/Desktop/Econometrics/Final Project/matches.csv", varnames(1) clear
** gen female = 1
 
/*
use "/Users/ishika/Desktop/Econometrics/Final Project/maledatset.dta", clear 
browse
drop loser_entry draw_size
append using femaledataset.dta, force
browse

use "/Users/ishika/Desktop/Econometrics/Final Project/femaledataset.dta", replace  
destring loser_rank, gen(loserrank)
destring winner_rank, gen(winnerrank) 


use "/Users/ishika/Desktop/Econometrics/Final Project/combineddataset.dta"

gen loser_rank1 = real(loser_rank + loserrank)


use "/Users/ishika/Desktop/Econometrics/Final Project/FinalDataSet.dta", replace


label var tourney_name "Name of the tournament"
label var surface "Surface of the court(hard,clay,grass)"
label var draw_size "Number of people in the tournament"
drop tourney_level 
label var tourney_date "Start date of tournament"
drop match_num
drop winner_id
label var winner_seed "Seed of winner"
label var winner_entry "How the winner entered the tournament"
label var winner_name "Name of winner"
label var winner_hand "Dominant hand of winner"
label var winner_ht "height in cm"
label var winner_ioc "Country of winner"
label var winner_age "Age of winner"
label var winner_rank "Rank of winner"
drop loser_id
label var loser_seed "Seed of loser"
label var loser_entry "How the loser entered the tournament"
label var loser_name "Name of loser"
label var loser_hand "Dominant hand of loser"
label var loser_ht "height in cm"
label var loser_ioc "Country of loser"
label var loser_age "Age of loser"
label var loser_rank "Rank of loser"
drop winner_rank_points loser_rank_points 

label var score "Final score"
label var best_of "Best of X number of sets"
label var round "Round (Round of 16, Quaterfinal, etc.)"
label var minutes "Match length in minutes"
label var w_ace "Number of aces for winner"
label var w_df "Number of double faults for winner"
label var w_svpt "Number of service points played by winner"
label var w_1stin "Number of first serves in for winner"
label var w_1stwon "Number of first serve points won for winner"
label var w_2ndwon "Number of second serve points won for winner"
label var w_svgms "Number of service games played by winner"
label var w_bpsaved "Number of break points saved by winner"
label var w_bpfaced "Number of break points faced by winner"
label var l_ace "Number of aces for loser"
label var l_df "Number of double faults for loser"
label var l_svpt "Number of service points played by loser"
label var l_1stin "Number of first serves in for loser"
label var l_1stwon "Number of first serve points won for loser"
label var l_2ndwon "Number of second serve points won for loser"
label var l_svgms "Number of service games played by loser"
label var l_bpsaved "Number of break points saved by loser"
label var l_bpfaced "Number of break points faced by loser"




label var female "Whether the player identifies as female or male"
label define female 1 "player identifies as female" 0 "player identifies as male"

gen date = substr(tourney_id, 1, 4)
destring date, gen(year)
drop date
label var year "Year of the tournament"

gen winnerhand = 0
label var winnerhand "Dominant hand of the winner"
label define winnerhand 1 "Right-handed" 0 "Left-handed"
replace winnerhand = 1 if winner_hand == "R"
drop winner_hand

gen loserhand = 0
label var loserhand "Dominant hand of the loser"
label define loserhand 1 "Right-handed" 0 "Left-handed"
replace loserhand = 1 if loser_hand == "R"
drop loser_hand

*/

use "/Users/ishika/Desktop/Econometrics/Final Project/FinalDataSet.dta", replace

reg winner_rank female

reg winner_rank female winner_age winner_ht winnerhand w_ace w_df w_1stin w_bpsaved
outreg2 using "FinalProject.doc", replace ctitle(Winner Statistics on Winner rank)

reg loser_rank female loser_age loser_ht loserhand l_ace l_df l_1stin l_bpsaved, r
outreg2 using "FinalProject.doc", append ctitle(Loser Statistics on Loser Rank)

encode winner_ioc, gen(winner_country)
encode loser_ioc, gen(loser_country)

outreg2 using x.doc, replace sum(log) keep(winner_rank female winner_age winner_ht winnerhand w_ace w_df w_1stin w_bpsaved)

outreg2 using x.doc, replace sum(log) keep(loser_rank female loser_age loser_ht loserhand l_ace l_df l_1stin l_bpsaved)

tab winner_country
tab loser_country

sum winner_rank

ttest winner_rank, by(female)

reg winner_rank female winner_age winner_ht winnerhand w_ace w_df w_1stin w_bpsaved

corr female winner_age winner_ht winnerhand w_ace w_df w_1stin w_bpsaved
estat vif
* Not concerning since less than 10

reg winner_rank female winner_age winner_ht winnerhand w_ace w_df w_1stin w_bpsaved
estat hettest


reg winner_rank female winner_age winner_ht winnerhand w_ace w_df w_1stin w_bpsaved
estat imtest, white


* outreg2 using "Summary table.doc", sum (winner_rank female winner_age winner_ht winnerhand w_ace w_df w_1stin w_bpsaved) replace eqkeep(N mean sd min max)


