# What Is Unclaimed Money?

If the government owes you money and you do not collect it, then it’s unclaimed. This can also happen with banks, credit unions, pensions, and other sources.

Beware of unclaimed money scams. There are people who pretend to be the government and offer to send you unclaimed money for a fee. Government agencies will not call you about unclaimed money or assets. [Learn how to spot these types of scams].

## What is the Unclaimed Money Application?

Currently, the government does not have one website for finding unclaimed money by name, state, or Social Security number (SSN).  This Unclaimed Money Application is a prototype which aims to simplify the process of finding unclaimed property under one place.  It also aims to integrate with the [MyUSA project] to provide support for [task lists], [forms], and notifications.

## Where to Look for Unclaimed Money

Until the Unclaimed Money Application is finished, you can visit each site separately and perform a search.

### States’ Unclaimed Money
* [Search by State] - Search your state’s listing of unclaimed funds and property.

### Retirement
* [Pensions from Former Employers] - Search for unclaimed pension money from companies that went out of business or ended a defined plan.

### Taxes
* [Tax Refunds] - The IRS may owe you money if your refund was unclaimed or undelivered.
* [Check the Status of Your Federal Tax Refund] - If you filed a federal tax return and expect a refund, you can check the status online.

### Banking, Investments, and Currency
* [Bank Failures] - Search the Federal Deposit Insurance Corporation (FDIC) for unclaimed funds from failed financial institutions.
* [Credit Union Failures] - Find unclaimed deposits from credit unions.
* [SEC Claims Funds] - The Securities and Exchange Commission (SEC) lists enforcement cases where a company or person owes investors money.
* [Damaged Money] - The Treasury Department will exchange mutilated or damaged U.S. currency.

### Mortgages
* [FHA-Insurance Refunds] - If you had an FHA-insured mortgage, you may be eligible for a refund from the Department of Housing and Urban Development (HUD).

### Savings Bonds
* [Search for Savings Bonds That Stopped Earning Interest] - Treasury Hunt allows you to search for bonds issued since 1974 that have matured and are no longer earning interest.
* [Calculate the Value] - Find the value of your paper savings bond.
* [Replace a Savings Bond] - Replace lost, stolen, or destroyed paper savings bonds.

### International
* [Foreign Claims] - U.S. nationals can find money owed to them from foreign governments after loss of property.

## Todo
* Add tests and integrate with [Travis CI]
* Access federal and state databases directly, via API, or via database import.
* Allow additional search parameters (e.g. first name, city, state, zip code, and SSN)
* Add geolocation to auto select state option based on IP
* Add additional states and services from the above list
* Add development/deploy guide (this application requires a good amount of server side libraries and binaries)



## Contributing
We love community contributions, and we work extra hard to make sure every code contribution is looked at and given feedback. To help everyone involved, please review our developer's guidelines to make sure all contributions are submitted smoothly.

### Developer's Guidelines

#### 1. Follow the style described in [A successful Git branching model].

#### 2. Does your pull request have tests?
We take testing very seriously. It’s important for maintaining long-term stability in a codebase, and it keeps unnecessary bugs from popping up. As a general rule of thumb, we usually don’t accept pull requests for features and fixes if there aren’t associated tests that come with them. “TEST EVERYTHING” is a great mentality to have for contributing code to the project.

Keep in mind, pull requests for obviously simple fixes like SASS/HAML corrections usually don’t need tests, but things that involve Javascript and heavy changes to underlying Ruby code certainly do. Here’s a [great guide] for getting started on that.

#### 3. Is your feature a really big feature?
Some features take a lot of time and discussion to determine how we can fit it into our current system’s design and use case. Adding really big features without consulting the team about implementation can occasionally lead to some problems, as that puts the requirement on the core team to help maintain new code while they develop the rest of the system. Additionally, some really big features require changing the way the system works to accommodate it. Communication is key here, so just talk to us.

#### 4. Is it a feature that currently fits into our design?
Occasionally, someone will make a really great pull request for something, and it might not be something we’re sure about including right away. Sometimes there are privacy implications that we have to think about, and other times we have to consider how a new feature would interact with the stream or other parts of the system. Occasionally, we’ll get a pull request that we don’t think really fits into the main codebase because of problems that would arise from this.

That doesn’t mean that we don’t think your feature is great, or that you shouldn’t continue developing it. It just means that perhaps your feature isn’t something we can incorporate at the very moment. To be clear: just because we reject a pull request once doesn’t mean that we won’t ever consider it in the future.

## License
[MIT License]

## Notes
Thanks to the Diaspora organization for their helpful wiki, much of which we copied from to build this [README] file.

  [Learn how to spot these types of scams]: http://www.consumer.ftc.gov/articles/0048-government-imposter-scams/
  [MyUSA project]: https://github.com/GSA-OCSIT/mygov-account
  [task lists]: https://github.com/GSA-OCSIT/mygov-admin-tasks
  [forms]: https://github.com/GSA-OCSIT/mygov-forms
  [Search by State]: http://www.unclaimed.org/
  [Pensions from Former Employers]: http://search.pbgc.gov/mp/
  [Tax Refunds]: http://www.irs.gov/uac/Does-the-IRS-Have-Money-Waiting-For-You%3F
  [Check the Status of Your Federal Tax Refund]: https://sa1.www4.irs.gov/irfof/lang/en/irfofgetstatus.jsp
  [Bank Failures]: http://www2.fdic.gov/funds/index.asp
  [Credit Union Failures]: http://www.ncua.gov/Resources/AM/Pages/UnclaimedDeposits.aspx
  [SEC Claims Funds]: http://www.sec.gov/divisions/enforce/claims.htm
  [Damaged Money]: http://moneyfactory.gov/damagedcurrencyclaim.html
  [FHA-Insurance Refunds]: http://www.hud.gov/offices/hsg/comp/refunds/index.cfm
  [Search for Savings Bonds That Stopped Earning Interest]: http://www.treasuryhunt.gov/
  [Calculate the Value]: http://www.treasurydirect.gov/BC/SBCPrice
  [Replace a Savings Bond]: http://www.treasurydirect.gov/indiv/research/indepth/ebonds/res_e_bonds_eereplace.htm
  [Foreign Claims]: http://www.fms.treas.gov/tfc/index.html
  [Travis CI]: https://travis-ci.org/
  [A successful Git branching model]: http://nvie.com/posts/a-successful-git-branching-model/
  [great guide]: https://wiki.diasporafoundation.org/Testing_Workflow
  [MIT License]: https://github.com/GSA-OCSIT/unclaimed_money/blob/master/LICENSE.md
  [README]: https://github.com/GSA-OCSIT/unclaimed_money/blob/master/LICENSE.md