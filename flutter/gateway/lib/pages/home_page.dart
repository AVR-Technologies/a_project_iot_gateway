import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => refresh());
    // refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IO Gateway Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // Card(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(8),
          //     side: BorderSide(width: 1, color: Colors.grey.shade400,),
          //   ),
          //   elevation: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Expanded(
          //         child: Column(
          //           children: [
          //             ListTile(
          //               title: Text('Sensors', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.normal),),
          //             ),
          //             const Divider(height: 0,),
          //             ListView.builder(
          //               shrinkWrap: true,
          //               physics: const ClampingScrollPhysics(),
          //               itemCount: Controller().inputPins.length,
          //               itemBuilder: (context, index) => Card(
          //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8,),),
          //                 elevation: 0,
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
          //                   child: ListTile(
          //                     title: Text(Controller().inputPins[index].label, textAlign: TextAlign.center,),
          //                     tileColor: Controller().inputPins[index].state > 0 ? Colors.green.shade200 : Colors.red.shade200,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             ListTile(
          //               title: Text('Loads', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.normal),),
          //             ),
          //             const Divider(height: 0,),
          //             ListView.builder(
          //               shrinkWrap: true,
          //               physics: const ClampingScrollPhysics(),
          //               itemCount: Controller().outputPins.length,
          //               itemBuilder: (context, index) => Card(
          //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8,),),
          //                 elevation: 0,
          //                 child: Padding(
          //                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
          //                   child: ListTile(
          //                     title: Text(Controller().outputPins[index].label, textAlign: TextAlign.center,),
          //                     tileColor: Controller().outputPins[index].state > 0 ? Colors.green.shade200 : Colors.red.shade200,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(8),
          //                     ),
          //                     onTap: ()=> updateState(index),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Sensors',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: Controller().inputPins.length,
                        padding: const EdgeInsets.all(
                          4.0,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            title: Text(
                              Controller().inputPins[index].label,
                              textAlign: TextAlign.center,
                            ),
                            tileColor: Controller().inputPins[index].state > 0
                                ? Colors.green.shade200
                                : Colors.red.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Loads',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: Controller().outputPins.length,
                        padding: const EdgeInsets.all(
                          4.0,
                        ),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListTile(
                            title: Text(
                              Controller().outputPins[index].label,
                              textAlign: TextAlign.center,
                            ),
                            tileColor: Controller().outputPins[index].state > 0
                                ? Colors.green.shade200
                                : Colors.red.shade200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onTap: () => updateState(index),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: Colors.grey.shade400,
              ),
            ),
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Speedometer',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                  ),
                ),
                const Divider(
                  height: 0,
                ),
                // ListTile(
                //   title: Text('Speedometer',
                //
                //     style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
                //     // style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                //   ),
                //   tileColor: Colors.indigo.shade400,
                //   shape: const RoundedRectangleBorder(
                //     borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                //   ),
                // ),

                SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 150,
                      ranges: <GaugeRange>[
                        GaugeRange(
                            startValue: 0,
                            endValue: 50,
                            color: Colors.green,
                            startWidth: 10,
                            endWidth: 10),
                        GaugeRange(
                            startValue: 50,
                            endValue: 100,
                            color: Colors.orange,
                            startWidth: 10,
                            endWidth: 10),
                        GaugeRange(
                            startValue: 100,
                            endValue: 150,
                            color: Colors.red,
                            startWidth: 10,
                            endWidth: 10)
                      ],
                      pointers: const <GaugePointer>[NeedlePointer(value: 90)],
                      annotations: const <GaugeAnnotation>[
                        GaugeAnnotation(
                          widget: Text('90.0',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          angle: 90,
                          positionFactor: 0.5,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: Colors.grey.shade400,
              ),
            ),
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Sensor status',

                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade900,
                        ),
                    textAlign: TextAlign.center,
                    // style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                  ),
                  tileColor: Colors.indigo.shade100,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: Controller().inputPins.length,
                  itemBuilder: (context, index) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade700,
                        foregroundColor: Colors.white,
                        child: Text(index.toString()),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        Controller().inputPins[index].label,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: Controller().inputPins[index].state > 0
                            ? Colors.green
                            : Colors.red,
                        radius: 10,
                      ),
                      // trailing: Text(Controller().inputPins[index].state == 1 ? "ON" : "OFF",
                      //   style: Theme.of(context).textTheme.headline6!.copyWith(
                      //     color: Controller().inputPins[index].state == 1 ? Colors.green : Colors.red,
                      //   ),
                      // ),
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                width: 1,
                color: Colors.grey.shade400,
              ),
            ),
            elevation: 0,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Load control',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.white),
                    // style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white,),
                  ),
                  tileColor: Colors.indigo.shade400,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: Controller().outputPins.length,
                  itemBuilder: (context, index) => Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 0,
                    child: SwitchListTile(
                      secondary: CircleAvatar(
                        backgroundColor: Colors.grey.shade700,
                        foregroundColor: Colors.white,
                        child: Text(index.toString()),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        Controller().outputPins[index].label,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.normal,
                            ),
                        // style: Theme.of(context).textTheme.headline6!,
                      ),
                      value: Controller().outputPins[index].state > 0,
                      onChanged: (bool value) => updateState(index),
                      activeColor: Colors.green,
                      activeTrackColor: Colors.green.shade200,
                      inactiveThumbColor: Colors.red,
                      inactiveTrackColor: Colors.red.shade200,
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  updateState(int index) {
    var state = Controller().outputPins[index].state == 1 ? 0 : 1;
    http
        .get(Uri.parse(
            'http://192.168.1.26/gateway/update/?name=${Controller().outputPins[index].name}&state=$state'))
        .then((value) {
      var response = jsonDecode(value.body);
      if (response['success']) {
        // setState(() => Controller().outputPins[index].state =
        //     Controller().outputPins[index].state == 0 ? 1 : 0);
        // refresh();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response['message'])));
      }
    });
  }

  refresh() {
    http.get(Uri.parse('http://192.168.1.26/gateway/pins/')).then((value) {
      var response = jsonDecode(value.body);
      if (response['success']) {
        setState(() => Controller().from(response['data'][0]));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response['message'])));
      }
    });
  }
}

enum PinType { input, output }

class Pin {
  final String name;
  final String label;
  final PinType type;
  int state;

  Pin(this.name, this.state, this.type, this.label);
}

class Controller {
  List<Pin> inputPins = [
    Pin('in1', 0, PinType.input, 'Sensor 1'),
    Pin('in2', 0, PinType.input, 'Sensor 2'),
    Pin('in3', 0, PinType.input, 'Sensor 3'),
    Pin('in4', 0, PinType.input, 'Sensor 4'),
  ];

  List<Pin> outputPins = [
    Pin('out1', 0, PinType.output, 'Load 1'),
    Pin('out2', 0, PinType.output, 'Load 2'),
    Pin('out3', 0, PinType.output, 'Load 3'),
    Pin('out4', 0, PinType.output, 'Load 4'),
  ];

  Controller._();
  static final Controller instance = Controller._();

  factory Controller() => instance;

  from(dynamic map) {
    inputPins[0].state = int.tryParse(map['in1']) ?? 0;
    inputPins[1].state = int.tryParse(map['in2']) ?? 0;
    inputPins[2].state = int.tryParse(map['in3']) ?? 0;
    inputPins[3].state = int.tryParse(map['in4']) ?? 0;

    outputPins[0].state = int.tryParse(map['out1']) ?? 0;
    outputPins[1].state = int.tryParse(map['out2']) ?? 0;
    outputPins[2].state = int.tryParse(map['out3']) ?? 0;
    outputPins[3].state = int.tryParse(map['out4']) ?? 0;
  }

  toMap() => {
        'in1': inputPins[0].state,
        'in2': inputPins[1].state,
        'in3': inputPins[2].state,
        'in4': inputPins[3].state,
        'out1': outputPins[4].state,
        'out2': outputPins[5].state,
        'out3': outputPins[6].state,
        'out4': outputPins[7].state,
      };
}
