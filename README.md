# Git Co-pilot

Easily populate Git commit messages when pairing

Git Co-pilot provides a Git commit message template that can be pre-populated with one or more `Co-authored-by` trailers when you are pair programming. These trailers tell GitHub that multiple users authored a commit. See [GitHub's docs](https://help.github.com/articles/creating-a-commit-with-multiple-authors/) for more information on this feature.

## Installation

Git Co-pilot requires Ruby 2.2 or newer.

Install it from RubyGems:

    $ gem install git-copilot

Then run `git-copilot init` to finish the setup. This will (optionally) add a `git copilot` alias and configure `git commit` to use a template managed by Git Co-pilot.

## Usage

These instructions assume that you've set up the Git alias `git copilot`. If you haven't, just run `git-copilot` instead of `git copilot`.

### Pairing and Soloing

When you are pair programming, run `git copilot pair` with the username(s) of the people you're pairing with.

    $ git copilot pair jake
    $ git commit
    # Write a commit message in your editor

    $ git show --no-patch
    commit 419493356d6ced752974104acf9698a94525a6da
    Author: John Smith <john.smith@example.com>
    Date:   Mon Feb 12 16:24:03 2018 -0500

        Refactor FooService

        Co-authored-by: Jake Johnson <jake.johnson@example.com>

You can also specify multiple pairs -- as many as you want!

    $ git copilot pair jake george
    $ git commit
    # Write a commit message in your editor

    $ git show --no-patch
    commit b1abdf4693e2da8977bf23de5765a3654532aba4
    Author: John Smith <john.smith@example.com>
    Date:   Mon Feb 12 16:24:03 2018 -0500

        Refactor FooService

        Co-authored-by: Jake Johnson <jake.johnson@example.com>
        Co-authored-by: George Geoffries <george.geoffries@example.com>

When it's time to go solo, run `git copilot solo`.

    $ git copilot solo
    $ git commit
    # Write a commit message in your editor

    $ git show --no-patch
    commit f438fbe9e8a9ef775821eb3c9ffd04a9e28216fa
    Author: John Smith <john.smith@example.com>
    Date:   Mon Feb 12 16:24:03 2018 -0500

        Fix failing test from refactor

### Managing Pairs

Before you can `git copilot pair` with someone, `git copilot` needs to know about them.

To add a pair, run `git copilot user add` with a "username" for the person you want to add. This username could be the person's username on GitHub or a company network, but it doesn't have to be; it's just how you will reference the user in `git copilot pair` commands.

    $ git copilot user add jake
    Git author name: Jake Johnson
    Git author email: jake.johnson@example.com

    Added Jake Johnson <jake.johnson@example.com> as "jake"!

If the user is on GitHub, you can import this information with the `--github` flag. If the details from GitHub are correct, you can just press "Enter" insted of re-entering them.

    $ git copilot user add --github jake
    Git author name [Jake Johnson]:
    Git author email [jake.johnson@example.com]:

    Added Jake Johnson <jake.johnson@example.com> as "jake"!

To remove a user, run `git copilot user remove` with the username you want to remove.

    $ git copilot user remove jake
    Remove Jake Johnson <jake.johnson@example.com>? y
    Removed jake!

To list all users that Git Co-pilot knows about, run `git copilot user list`.

    $ git copilot user list
    Jake Johnson <jake.johnson@example.com>
    George Geoffries <george.geoffries@example.com>

### Advanced Configuration

Git Co-pilot stores all of its data at `$HOME/.gitcopilot.yml`. The structure of the file looks something like this:

```yaml
---
template: |
  # Write your commit message here

  %{coauthors}
users:
  jake:
    name: Jake Johnson
    email: jake.johnson@example.com
  george:
    name: George Geoffries
    email: george.geoffries@example.com
```

## Development

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/atmattpatt/git-copilot.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
