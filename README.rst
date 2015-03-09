======
Readme
======

Build AMIs for Team unPRO

------------
Requirements
------------

Install

* invoke_
* boto_
* packer_

.. _invoke: https://github.com/pyinvoke/invoke
.. _boto: https://github.com/boto/boto
.. _packer: https://github.com/mitchellh/packer

Put your AWS credentials in `~/.boto`.

~~~~~~
Extras
~~~~~~

If you're running into timeouts during the build, compile packer yourself with `mitchellh/goamz#180`__.

.. _PR: https://github.com/renat-sabitov-sirca/goamz

__ PR_

-------
Running
-------

::

$ invoke build


