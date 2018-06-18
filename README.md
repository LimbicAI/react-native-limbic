# React Native Limbic
A React Native bridge module for interacting with Limbic's SDK. Checkout the [native iOS repository](https://github.com/limbicAI/Limbic-iOS)

## Installation

Install the [react-native-limbic] package from npm:

- Run `npm install limbic-react-native --save`
- Run `react-native link react-native-limbic`

This is the first version of a react-native bridge for Limbic. Therefor, a bit of manual installation is needed in the project itself. In future updates, we'll include a build script that will take care of most of this for you.

1. Update `info.plist` in your React Native project
```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
```
2. In `Build Settings`, turn `Enable Bitcode` to `NO`.

3. In `Build Settings`, Search `FRAMEWORK_SEARCH_PATHS` and add `$(SRCROOT)/../node_modules/react-native-limbic`
4. In `Build Settings`, Search `ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES` -> Set to `YES`.
5. In the general General tab, under `Embedded Binaries` Add `node_modules/react-native-limbic/Limbic.framework`

## Get Started
Set your API key, turn call our stress function. That's how simple.
Here's an example of how you would get someone's stress levels and store + display the values via state.

```javascript
import Limbic from 'react-native-limbic';

...

let limbic = new Limbic({
  apiKey: "7b75186d-6534-44d0-9c66-8e407a165438",
});

export default class App extends Component<Props> {
  state = {
    stress: null,
  }

  componentDidMount() {
    limbic.getStressForCurrentUser(new Date(), new Date())
    .then((stress) => {
      this.setState({ stress });
    })
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit App.js
        </Text>
        <Text style={styles.instructions}>
          {this.state.stress}
        </Text>
      </View>
    );
  }
}
```

## Return values

```javascript
"2018-05-29 23:00:00 +0000" : {
  confidence = "1.000001054754341";
  confidenceLevel = 2;
  stressIndex = 0;
  stressLevel = 4;
};
```
* `confidence` means the **confidence interval** in which we are 95% confident the `stressIndex` lies.
* `confidenceLevel` can either be 1 or 2. `1` stands for *certain*, and a `2` stands for *uncertain*. This is the certainty about the stress prediction.
* `stressIndex` is an index, as calculated from the person's own baseline on their stress level. Anything above 0 would mean *more stressed than average*, anything below *less stressed than average*.
* `stressLevel` is the recommended way to report on a user's stress levels. The value can range from 1 to 7. Below is a breakdown of all possible values:

```bash
1 -- A very calm day
2 -- A calm day
3 -- A slightly calm day
4 -- A normal day
5 -- A slightly stressful day
6 -- A stressful day
7 -- A very stressful day
```

**Please note that we promote the usage of `stressLevel` and `confidenceLevel` as these values are more easily understood by the user.**
