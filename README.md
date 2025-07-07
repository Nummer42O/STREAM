# STREAM (evaluation)

This is the (evaluation branch of the) STREAM proof of concept implementation, combining the work of G. Muck and J. Kohl in order to evaluate the latter.

This `evaluation`-branch features the code that performs the normal operation of the STREAM FDD pipeline, while `evaluation-full` contains the abridges version that performs the holistic operation.

## Usage

### preparation

Before building, the following manual changes need to be performed:

In [`STREAM-DSM/ws/src/stream/tracer/src/structuralLO/tracer.cpp`](STREAM-DSM/ws/src/stream/tracer/src/structuralLO/tracer.cpp#L84) comment out:
```c++
.buf_type   = LTTNG_BUFFER_PER_UID,
```

In [`STREAM-DSM/ws/src/dbs/src/curl/myCurl.cpp`](STREAM-DSM/ws/src/dbs/src/curl/myCurl.cpp#L9) change:
```c++
#define URLNEO4J "http://localhost:7474"
#define URLINFLUXDB "http://localhost:8086"
```
to
```c++
#define URLNEO4J "http://neo4j:7474"
#define URLINFLUXDB "http://influxdb:8086"
```

# running

All of the following commands are to be executed from the root of the workspace, unless stated otherwise.
All actions are expected to be run inside [the docker container](.devcontainer/Dockerfile).

The build process includes:

0. Build everything, by running all 3 build scripts in [.vscode/scripts](.vscode/scripts/).

1. Start the tracers and monitors by running `bash -- .vscode/scripts/start-stream.bash . debug`. This will open a terminator window in which no further action needs to be taken if all processes are running. Note, that the message queue monitor will throw an exception until stream is running, which is fine. Furthermore, the warning about the local setup of the babeltrace plugins package not being found can be safely ignored.

2. Run `bash -- .vscode/prelaunch-reset.bash` to reset before starting the application if it ran before.

3. Source ROS2 and the workspace in STREAM-DSM. Then start the data management by running `ros2 run datamgmt datamgmt`. The error of the message queue monitor should disappear.

4. Start the FDD pipeline by running `./STREAM-FDL/build/main STREAM-FDL/example-config.json`.

5. Start the payload by running `bash -- .vscode/scripts/launch-irobot-benchmark.bash .`.

6. Run until the FDD pipeline exits, upon which the runtime will be printed to stdout. All log messages are printed to stderr. The runtime characteristics, such as CPU utilisation and RAM usage can be read from a [Grafana interface](http://localhost:3000/).

# observations

Observations about the performance can be made in [grafana](http://localhost:3000/?orgId=1&from=now-6h&to=now&timezone=browser), for more detauls conslut the [STREAM-DSM](https://github.com/KARTOFF8xE/STREAM-DSM/tree/finalize/evaluationTools).
Observations about the runtime can be made on the stdout pipe.
