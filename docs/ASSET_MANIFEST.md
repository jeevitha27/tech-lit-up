# Asset manifest

`photos/` holds every original you shared (HEIC converted to JPG, very large PNGs saved as JPG). `assets/img/` holds the cropped, resized versions the prototype loads. Photos are only cropped and resized, never edited.

| Original in `photos/` | Used on the site as (`assets/img/`) | Where it appears |
|---|---|---|
| 01-branding/tech-light-up-vision-illustration | branding/vision-banner, vision-person-* (6 crops) | Home: vision banner, empowerment banner |
| 02-ngos/win-vinaya-job-poster-deaf-candidates | ngos/win-vinaya-job-poster | Partner NGO card |
| 02-ngos/unnati-foundation-ramesh-swamy-interaction | ngos/unnati-interaction-poster | Partner NGO card |
| 02-ngos/vindhya-hands-of-inclusion-logo | ngos/vindhya-hands-of-inclusion | Partner NGO card |
| 03-talent.../art-and-culture-dancer | talent/art-and-culture-dancer | Hero ring centre, workshop card |
| 03-talent.../performance-glimpse-collage | talent/performance-glimpse-1 to 5 | Hero ring, photo strips, Talent gallery |
| 03-talent.../meet-the-dancers | talent/dancer-renuka, sridevi, chinnari, usha, praveen | Talent cards, strips |
| 03-talent.../sunadha-band, sunadha-dance-troupe | talent/sunadha-band, sunadha-dance-troupe | Hire featured talent, Talent cards |
| 03-talent.../bharatnatyam-sunadha-collage | not used | Spare |
| 04-workshops-upcoming/committees-beneficiary-guidance-execution | workshops/committee-*, ngos/samarthanam-sunadha-poster | Upcoming workshops, Samarthanam card |
| 04-workshops-upcoming/speechcraft-effective-communication-slide | data in `seed.json` (5 steps, team) | Upcoming workshop 2 |
| 05-workshops-past-christel-house/csr-workshops-christel-house | workshops/past-christel-house-1 to 9 | "Workshops & Learning Initiatives" |
| 06-moments-unnati-foundation/valedictory-function-01 to 09 | moments/unnati-valedictory-1 to 9 | "Moments of Connection & Impact" collage |
| 07-experts/jeevitha-pandurangaiah/profile | experts/jeevitha-profile | Expert card and profile |
| 07-experts/cm-manjunath/* | experts/manjunath-* | Expert card cover, Know more showcase |
| 07-experts/srujana-kodati/* | experts/srujana-* | Expert card, Know more showcase |
| 08-design-references/* | not used | Visual references for agents (OKRE look, slides, templates) |
| 09-earlier-deck-assets/* | not used | Material from the earlier PowerPoint |

## Not in the files
Workshop and career pictures are drawn in code (`app.js`, functions `SC`, `per`, `svg`), not image files. In production, replace them with real photos where you have consent.
