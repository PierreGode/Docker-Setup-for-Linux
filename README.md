<h3>Docker CE Installation Tool</h3>

This is a simple yet powerful Bash script tool designed to facilitate the process of installing Docker CE (Community Edition) on Linux systems.

With this tool, users can quickly setup Docker CE without having to manually execute all the installation steps. It's perfect for developers, system administrators, or any Docker enthusiasts who frequently install Docker CE for testing, development, or production deployment.

Features

Interactive UI: The tool provides an interactive command-line interface that guides you through the process, offering options to install Docker CE and setup Docker Swarm manager or worker.
Prompt-based confirmations: Every significant operation (like Docker installation or Swarm setup) requires user confirmation, thus preventing accidental execution of unwanted operations.
Simplified Swarm setup: The tool also simplifies the process of setting up Docker Swarm, with separate functions to initialize a Swarm manager and join a Swarm worker.
Prerequisites

The script is meant to be run on Linux systems, specifically those based on Debian (like Ubuntu), and assumes you have sudo privileges. Before running, make sure the necessary packages (tput, apt-transport-https, ca-certificates, curl, software-properties-common) are installed on your system.

Usage

First, download the script and make it executable:

bash
```
chmod +x docker.sh
```
To run the script, use the following command:

bash
```
sudo ./docker.sh
```
Follow the on-screen instructions provided by the tool. Choose the desired option for installing Docker CE or setting up Docker Swarm.

Caution

This script involves significant changes to your system (installing and removing software).

Contribution

This project is open source under the terms of the GNU General Public. Contributions, issues, and feature requests are welcome!

Author

Pierre Gode
