# Everest
Everest is my interactive job-application app for Basecamp. It pays homage to the classic Basecamp 3 web UI design and provides an easy way to access recent content I have created. As a supplement to the copy in the application itself, this README will help the reader sift through the myriad of GitHub projects I have worked on since the fall of 2017.

## Contents
 1. [A brief tour of historical repos in my GitHub and an explanation of their place in my journey](https://github.com/jhunschejones/Everest#from-the-beginning)
 2. [More recent projects demonstrating familiarity with Ruby on Rails and good web development habits](https://github.com/jhunschejones/Everest#notable-projects)
 3. [Everest: key features and future improvements](https://github.com/jhunschejones/Everest#everest-1)

## From the beginning
After googling "what software language do I learn for web development," or something to that extent in the fall of 2017, I found myself in possession of a two books by Michael Hartl and Zed Shaw which quickly lead me down the rabbit hole into the amazing world of Ruby and Ruby on Rails. My first ever coding project was a CLI, text adventure game called [Rangor](https://github.com/jhunschejones/Rangor) that I built for my partner who is a fan of all stories involving small animals.

From there, I kicked off phase one of my plan for getting into the world of software engineering. I began attending a coding bootcamp in Portland, OR where I completed several basic HTML and CSS sites before progressing to some courses on C# and .NET backend development. In my spare time, I also learned some Node.js and backend JavaScript development as well *(I created a bootcamp [portfolio available here](https://github.com/jhunschejones/The-Tech-Academy-Projects), for those who are curious.)*

In phase two of my plan, I put together an [internship](https://github.com/jhunschejones/Developer-Internship) at my then-current employer Providence Health Plans through a connection I made at a leadership class I taught. I would arrive at work early to write code, then complete my normal day job, then finally ride the Max into downtown Portland to work on the second part of my coding bootcamp in the evening.

In June of 2018 I was hired into the Support Engineering organization at New Relic after graduating from bootcamp. While working as a Business Support Engineer, I wrote more Ruby and JavaScript apps, including a [full stack Express.js + HTML app](https://github.com/jhunschejones/Album-Tags) that I used to share albums I love with my friends.

In 2019 I finally completed phase three of my journey and was hired as an Associate Software Engineer into New Relic's Ignite program, a selective, fast-track program for early career engineers. While participating in Ignite I learned [more Ruby](https://github.com/jhunschejones/Ruby-Projects), [Elixir](https://github.com/jhunschejones/Elixir-Projects), and [a bit of Java](https://github.com/jhunschejones/Java-Projects), all while contributing code and working alongside various engineering teams around the company. In June of 2019, I was hired out of the program to work on the IAM teams as a Software Engineer, and this is where I still work today!

## Notable projects
Over the last few years I have worked hard to push my Ruby on Rails and web development skills to new levels. Some projects that I am incredibly proud of include:
 * [Flashcards](https://github.com/jhunschejones/Flashcards) - A full stack Ruby on Rails app for language learning flashcards, optimized for mobile use and data efficiency
 * [Music Like You Mean It](https://github.com/jhunschejones/Music-Like-You-Mean-It) - A full stack Ruby on Rails CMS and blog for managing online teaching content that I created for training aspiring music producers
 * [Studio Project Manager](https://github.com/jhunschejones/Studio-Project-Manager) - A Basecamp-inspired, Ruby on Rails + Stimulus project management application for managing recording projects I work on with clients in my home studio
 * [Rails Game](https://github.com/jhunschejones/Rails-Game) - A full stack Ruby on Rails application using ActionCable for a customizable, realtime turn / dice game *(turned out to be valuable during quarantine!)*
 * [To-Love-Roo-2](https://github.com/jhunschejones/To-Love-Roo-2) - A full stack Sinatra app I use to leave surprise notes for my partner during busy work days
 * [Counseling Book Tags](https://github.com/jhunschejones/Counseling-Book-Tags) - A full stack Rails + Stimulus app for my partners's graduate school cohort, allowing her classmates and her to share counseling book resources

## Everest
And that brings us here, to Everest! This is a scaled-down Basecamp 3 replica that I put together in spare moments scavenged over two weeks in order to demonstrate both a bit of my Rails familiarity, and as a creative way to pull together relevant artifacts for you, my future Basecamp interviewers.

### Key features

***Extensibility***

In order to better demonstrate how I might approach a project like this in the real world, I tried to build Everest in an extensible fashion, such that I would be able to create additional projects with fairly little effort and the UI would adapt accordingly.

***Responsive design***

I am especially proud of the way I was able to use a bit of Ruby and some CSS flexbox to get the activity timeline to alternate left-to-right from one month to the next, similar to the Basecamp 3 UI. I also used CSS to recreate the Basecamp 3 place-holder avatars, instead of using images to reduce extra asset storage.

Viewers of the site will also notice that it adapts well on mobile screens as well. Everest is an application for the modern web and I am a strong proponent of responsive UIs whenever possible, even when native mobile apps are an option *(as in Basecamp’s case.)* Bonus fact -- I also started learning Swift in 2020 just for fun and to keep the creative juices flowing. Perhaps a native Everest app could lie in my future?

***HTML-first UIs***

For interactive elements like the flashes and mobile dropdown menu, I used Stimulus for a clean way to organize this code. Other than that, the entire site is HTML to the core, just how I like it! To keep the site feeling responsive, I also did a bit of view caching with Redis to improve the pages that need to render lists of elements repeatedly.

***Secure to the core***

Even on project-scale applications, I like to default to secure data storage whenever possible. In Everest, user names and email addresses are encrypted in the database to prevent personal data leaks should an attacker gain access to the database itself. I also included thorough unit tests for all critical application functionality. I do not consider important code to be fully functional until I have tests proving it works. That said, I do not shoot for 100% test coverage, but rather enough coverage that I know all the elements will still function if I come back to change something several months from now.

### Future improvements
It has been my dream to work at Basecamp ever since I first heard DHH explaining his vision for modern software develpment on Tim Ferriss’ podcast, and I plan to continue to expand this application for future application submissions if this second attempt is still not the right timing. The next step will likely be to expand the user management tooling to allow users to sign up and create their own projects, or at least contribute to existing projects. I would also be interested in adding more “project tool” categories like a project chat, or the ability for users to comment on resources like todo lists, todo items, or documents.

Thanks for taking the time to read through this documentation! I am happy to answer any questions and can be reached at joshjones@hey.com.
