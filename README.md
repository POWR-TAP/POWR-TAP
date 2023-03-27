# POWR-TAP

## Architecture of Projects

About: TAP is a video-based, multiple-choice, pop quiz gaming app where players receive push notifications with links to quiz videos (1-2 minute runtime) that contain pertinent financial skill building information and must answer multiple-choice questions correctly to win $5. Each player is given two (2) chances per quiz and bonus rounds allow winners to level-up their winnings.

TAP by POWR is a combination of social media platform Tik Tok, in that videos are used to convey messaging, and HQ, which is a multiple choice, pop quiz trivia game that rewards winners with real money. We've taken the best of both worlds and added a few twists.

Design: Our build is centered around customized learning modules and  badging/tagging system that tracks players' performance and informs the leaderboard. As it stands, our video-based quiz system is correlated to multiple choice questions that are tagged when correctly answered and ascribed a badget that remains on that user's profile. This data is then extracted by our Internal Reporting System that then determines the amount of cash each player is owed in a give period. Once approved by FIS, our payment partner, the funds are distributed to each user's debit card for them to use at their descretion. 


The reporting code is available in this repository under the `./data` directory
and the sub README in that folder contains the technical architecture of that
part of the project.
