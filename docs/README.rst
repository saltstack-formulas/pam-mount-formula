.. _readme:

pam-mount-formula
=================

|img_travis| |img_sr| |img_pc|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/pam-mount-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/pam-mount-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release
.. |img_pc| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
   :alt: pre-commit
   :scale: 100%
   :target: https://github.com/pre-commit/pre-commit

Configure automounting with `pam-mount`_.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please pay attention to the ``pillar.example`` file and/or `Special notes`_ section.

Contributing to this repo
-------------------------

Commit messages
^^^^^^^^^^^^^^^

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``. ::

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

Special notes
-------------

None

Available states
----------------

.. contents::
   :local:

``pam-mount``
^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the required packages and manages the pam-mount
configuration file.

It depends on:

- `pam-mount.package`_
- `pam-mount.config`_

``pam-mount.package``
^^^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

Managage packages required to use `pam-mount`_.

``pam-mount.package.install``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install the `pam-mount`_ package and the declared dependencies.

``pam-mount.config``
^^^^^^^^^^^^^^^^^^^^

This state will configure ``pam_mount.conf.xml`` for the declared volumes.

It depends on:

- `pam-mount.package.install`_

``pam-mount.clean``
^^^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This state will undo everything performed in the `pam-mount`_ meta-state in reverse order, i.e.
removes the configuration file and then uninstalls the packages.

It depends on:

- `pam-mount.config.clean`_
- `pam-mount.package.clean`_

``pam-mount.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the `pam-mount`_ configuration file.

``pam-mount.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the `pam-mount`_ package.

It depends on:

- `pam-mount.config.clean`_


Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``pam-mount`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.


.. _pam-mount: http://pam-mount.sourceforge.net
