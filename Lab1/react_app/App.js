/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  Button,
  Image,
  TextInput,
} from 'react-native';

import { Header, Input} from 'react-native-elements';


const App: () => React$Node = () => {
  return (
    <View style={styles.center}>
      <StatusBar barStyle="dark-content" hidden = {false} backgroundColor ="#0E5C40" translucent = {true}/>
      <Header centerComponent={{text: 'Lab 1 - React Native', style: {color: "white", fontSize: 20}}} backgroundColor ="#2D8A68"/>
      <Image
        style={styles.imgStyle}
        source={require('./react.png')}
        />

      <View style={styles.row}>
        <View style={styles.col}>
          <View style={styles.buttonBox}>
            <Button title="BUTTON" color="#BFBFBF"/>
          </View>
          <View style={styles.buttonBox}>
            <Button title="BUTTON" color="#BFBFBF"/>
          </View>
        </View>
        <View style={styles.col}>
          <View style={styles.buttonBox}>
            <Button title="BUTTON" color="#BFBFBF"/>
          </View>
          <View style={styles.buttonBox}>
            <Button title="BUTTON" color="#BFBFBF"/>
          </View>
        </View>
      </View>
      <View style={styles.row}>
        <Text style={styles.textStyle}>Email</Text>
        <TextInput style={styles.inputStyle}/>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  center: {
    flex: 1,
    alignItems: "center",
  },
  row: {
    flex: 1,
    flexDirection: 'row',
  },
  col: {
    flex: 1,
    flexDirection: 'column',
    alignItems: "center",
  },
  buttonBox: {
    flexDirection: 'column',
    margin: 12,
  },
  imgStyle: {
    height:150,
    width: 150,
    margin: 30,
  },
  inputStyle: {
    marginBottom: 230,
    width: 250,
    borderBottomWidth: 1,
    borderBottomColor: 'red',
  },
  textStyle: {
    textAlign: "left",
    color: "grey",
    fontSize: 18,
    padding: 3
  }
  })

export default App;
