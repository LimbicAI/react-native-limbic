import React from 'react';
import {
  NativeModules,
  requireNativeComponent
} from 'react-native';

// LIMBIC STUFF
const LimbicNative = NativeModules.LimbicRN;
let limbic_error_map = {
  '0': 'Not enough data available',
  '1': 'No access to available data sources',
  '2': 'No internet connection',
  '3': 'Operating system is not supported. Limbic only supports iOS 11 and up.',
  '4': 'An unexpected error occured'
}

class LimbicError extends Error {}

class Limbic {
  // TODO add check for throw error when user is on android
  constructor({ apiKey } = {}) {
    if (apiKey == null) {
      throw new Error(`Limbic apikey has to be provided`);
    }

    this.apiKey = apiKey;
  }

  async getStressForCurrentUser(startDate, endDate, data=null) {
    try {
      const stressArray = await LimbicNative.getStressForCurrentUser(startDate, endDate, data, this.apiKey);
      return stressArray.map(stressObj => {
        return {
          date: new Date(stressObj.key*1000),
          stress: stressObj.value
        };
      });
    } catch (e) {
      let err_message = limbic_error_map[e.code];
      // TODO Check domain as well
      if (err_message) {
        throw new LimbicError(err_message);
      } else {
        throw new Error(e.message);
      }
    }
  }
}

export default Limbic
