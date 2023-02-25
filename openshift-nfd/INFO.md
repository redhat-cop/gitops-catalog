# nfd

The Node Feature Discovery Operator manages the detection of hardware features and configuration in a Kubernetes cluster by labeling the nodes with hardware-specific information. The Node Feature Discovery (NFD) will label the host with node-specific attributes, like PCI cards, kernel, or OS version, and many more.

NFD consists  of the following software components:

The NFD Operator is based on the Operator Framework an open source toolkit to manage Kubernetes native applications, called Operators, in an effective, automated, and scalable way.

##NFD-Master
NFD-Master is the daemon responsible for communication towards the Kubernetes API. That is, it receives labeling requests from the worker and modifies node objects accordingly.

##NFD-Worker
NFD-Worker is a daemon responsible for feature detection. It then communicates the information to nfd-master which does the actual node labeling. One instance of nfd-worker is supposed to be running on each node of the cluster.

##NFD-Topology-Updater
NFD-Topology-Updater is a daemon responsible for examining allocated resources on a worker node to account for resources available to be allocated to new pod on a per-zone basis (where a zone can be a NUMA node). It then communicates the information to nfd-master which does the NodeResourceTopology CR creation corresponding to all the nodes in the cluster. One instance of nfd-topology-updater is supposed to be running on each node of the cluster.