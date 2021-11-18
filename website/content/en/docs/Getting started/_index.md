---
categories: ["Examples", "Placeholders"]
tags: ["docs"] 
title: "Getting Started"
linkTitle: "Getting Started"
weight: 2
description: >
  Simple to get start with LambdaStack
---

{{% pageinfo %}}
LambdaStack comes with a number of simple defaults that only require Cloud vendor Key/Secret or UserID/Password!
{{% /pageinfo %}}

Information in this section helps your user try your project themselves.

* What do your users need to do to start using your project? This could include downloading/installation instructions, including any prerequisites or system requirements.

* Introductory “Hello World” example, if appropriate. More complex tutorials should live in the Tutorials section.

Consider using the headings below for your getting started page. You can delete any that are not applicable to your project.

## Prerequisites (Runtime only - no development)

LambdaStack works on OSX, Windows, and Linux. You can launch it from your desktop/laptop or from build/jump servers. The following are the basic requirements:
* Docker
* Git (only if using GitHub fork/cloning to download the source code)
* Internet access (can be executed in an air-gapped environment - details in documentation)
* Python 3.x is **NOT** required. It's listed here just to illustrate it's not actually required. The LambdaStack container has it already built in

## Prerequisites (Development)

If you plan to contribute to the LambdaStack project by doing development then you will need a development and build environment. LambdaStack works on OSX, Windows, and Linux. You can launch it from your desktop/laptop or from build/jump servers. The following are the basic requirements for development:
* Docker
* Git
* GitHub account - Free or paid. You will need to Fork LambdaStack to your GitHub account, make changes, commit, and issue a pull request. The development documentation details this for you with examples
* Internet access (can be executed in an air-gapped environment - details in documentation). If your environment requires proxies then see documentation on how to set that up)
* Python 3.x
* IDE (Visual Code or PyCharm are good environments). We use Visual Code since it's open source. We recommend a few plugin extensions but they get automatically installed if you follow the instructions in the documention on setting up your development environment using Visual Code
* Forked and cloned LambdaStack source code - Start contributing!

## Installation

Where can your user find your project code? How can they install it (binaries, installable package, build from source)? Are there multiple options/versions they can install and how should they choose the right one for them?

## Setup

Is there any initial setup users need to do after installation to try your project?

## Try it out!

>As of LambdaStack v1.3, there are two ways to get started:
* Fork/Clone the LambdaStack GitHub repo at https://github.com/lambdastack/lambdastack
* Simply issue a `Docker run ...` command

>The newest version, LambdaStack v2.0 soon to be pre-released, will have a full Admin UI that will use the default APIs/CLI to manage the full automation of Kubernetes

