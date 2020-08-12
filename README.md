# Everest
Everest is my interactive job-application app for Basecamp. It pays homage to the classic Basecamp 3 web UI design, and provides an easy way to access recent content I've created.  As a supplement to the copy in the application itself, this README will help the reader sift through the myriad of GitHub projects I've worked on since the fall of 2017.

## From the beginning
After googling "what software language for web development" or something to that extent in the fall of 2017, I found myself working through a couple books by Michael Hartl and Zed Shaw and falling head over heels into the world of Ruby and Ruby on Rails. My first ever coding project is a CLI text adventure game called [Rangor](https://github.com/jhunschejones/Rangor) that I built for my wife who is a fan of any story about small animals.

From there I began attending a .NET bootcamp in Portland, OR where I completed several basic HTML and CSS sites before progressing to some courses on C# and .NET backend development. In my spare time, I learned some Node.js and backend JavaScript development as well _(I created a bootcamp [portfolio available here](https://github.com/jhunschejones/The-Tech-Academy-Projects), for those who might be curious.)_

From there I put together an [internship](https://github.com/jhunschejones/Developer-Internship) at Providence Health Plans through a connection I made at a leadership class I taught, all while still working my day job and finishing up the second part of my coding bootcamp.

In 2018 I was hired at New Relic into the Support Engineering organization. While working as a Business Support Engineer, I wrote more ruby and JavaScript apps, including a [full stack Express.js + HTML app](https://github.com/jhunschejones/Album-Tags) that I used to share albums I love with my friends.

In 2019 I was hired as an Associate Software Engineer into New Relic's Ignite program, during which I learned [more Ruby](https://github.com/jhunschejones/Ruby-Projects), [Elixir](https://github.com/jhunschejones/Elixir-Projects), and [a bit of Java](https://github.com/jhunschejones/Java-Projects). I was hired out of the program to work on the IAM teams as a full Software Engineer, and this is where I still work today!

## Notable projects
Over the last year + I have pushed my Ruby on Rails and web development skills to new levels. Some projects that I'm incredibly proud of include:
* [Counseling Book Tags](https://github.com/jhunschejones/Counseling-Book-Tags) - A full stack Rails + Stimulus app for my wife's graduate school cohort, allowing her classmates and her to share counseling book resources
 * [Studio Project Manager](https://github.com/jhunschejones/Studio-Project-Manager) - A Basecamp-inspired, Ruby on Rails + Stimulus project management application for managing recording projects I was working on with clients in my home studio
 * [Rails Game](https://github.com/jhunschejones/Rails-Game) -  A full stack Ruby on Rails application using ActionCable for a customizable, realtime turn / dice game *(turned out to be valuable during quarantine!)*
 * [To-Love-Roo-2](https://github.com/jhunschejones/To-Love-Roo-2) -  A full stack Sinatra app I use to leave surprise notes for my wife during busy work days
 * [Music Like You Mean It](https://github.com/jhunschejones/Music-Like-You-Mean-It) - A full stack Ruby on Rails CMS and blog for managing online teaching content I created for training aspiring music producers

## Everest
And that brings us here, to Everest! This is a small-scale Basecamp 3 replica that I put together in spare moments scavenged over less two weeks in order to demonstrate both a bit of my Rails familiarity, and as a creative way to pull together relevant artifacts for interviewers.

### Key features
In order to better demonstrate how I might approach a project like this in the real world, I tried to build Everest in an extensible fashion such that I would be able to create additional projects with fairly little effort and the UI would adapt accordingly.

I'm especially proud of the way I was able to use a bit of Ruby and some CSS flexbox to get the activity timeline to alternate left-to-right from one month to the next, similar to the Basecamp 3 UI. I also used CSS to recreate the Basecamp 3 place-holder avatars, instead of using images to reduce extra asset storage.

Viewers of the site will also notice that it adapts well on mobile screens as well. In 2020 I started learning Swift since I'm sure Basecamp uses this at least a little for their native IOS app, and I appreciate the ways learning new languages expand my understanding of software engineering in general. All that to say, Everest is an application for the modern web and I am a strong proponent of responsive UIs whenever possible, even when native mobile apps are an option.

For interactive elements like the flashes and mobile dropdown menu, I used Stimulus for a clean way to organize this code. Other than that, the entire site is HTML to the core, just how I like it! To keep the site feeling responsive, also I did a bit of view caching with Redis to improve the pages that need to render lists of elements repeatedly.

### Future improvements
It is my dream to work at Basecamp, and I plan to continue to expand this application for future application submissions if this first one isn't the right timing. The next step here is likely to expand out the user management tooling to allow users to sign up and create their own projects, or at least contribute to existing projects. I would also like to add more project tool categories, like maybe a chat or a to-do list _(the Basecamp 3 todo list is my favorite feature in the app!)_
