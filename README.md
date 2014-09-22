## PDToolbox


PDToolbox is a matlab implementation of some evolutionary dynamics from game theory. The current version supports the implementation of replicator dynamics, Maynard Smith's replicator dynamics, Smith dynamics, logit dynamics, and Brown-von Neumann-Nash dynamics. Also, it can be used to run revision protocols, that is, population games with small number of agents per population. This toolbox is designed to facilitate the implementation of any game, regardless of the number of populations, strategies per population, and fitness function. It has some pre-build methods to implement different dynamics, revision protocols, and to plot the evolution of the state of each population. This software is distributed under BSD license.


## Installation

1. Download files from the 'git' repository with the following command:


	git clone https://github.com/carlobar/PDToolbox_matlab


Or download and extract the files directly from the following link: 


	https://github.com/carlobar/PDToolbox_matlab/archive/master.zip


2. Open matlab and add the path of the following directories:

	path(path, '[download directory]/PDToolbox_matlab')

	path(path, '[download directory]/PDToolbox_matlab/dynamics')

	path(path, '[download directory]/PDToolbox_matlab/graphs')

	path(path, '[download directory]/PDToolbox_matlab/test')


The path can be verified with the command 'path'.


## Running the toolbox

In order to use the toolbox we must define the parameters of the game in a data structure. Some parameters that must be defined are: 

	* Number of populations, 
	* Strategies of each population
	* Evolutionary dynamics
	* ODE solver
	* Fitness function


The following examples are included in the 'test' directory:

	'test1.m' contains an example of a game with one population and three strategies per population.
	'test2.m' example of a game with two population and two strategies per population.
	'test3.m' example of a game with one population, three strategies per population, and combined dynamics.
	'test_finite_population1.m' is an example of the evolution of a game with small number of agents per population.
	'electricity grid/test_electricity_system.m' example of an application of population dynamics to the implementation of demand response programs.

## License


PDToolbox is released under the [BSD License](http://opensource.org/licenses/BSD-3-Clause)

