/* global axios */
import ApiClient from './ApiClient';

class AccountBrandingAPI extends ApiClient {
  constructor() {
    super('accounts');
  }

  get(accountId) {
    return axios.get(`${this.url}/${accountId}/branding`);
  }

  update(accountId, payload, isMultipart = false) {
    if (isMultipart) {
      return axios.put(`${this.url}/${accountId}/branding`, payload, {
        headers: { 'Content-Type': 'multipart/form-data' },
      });
    }

    return axios.put(`${this.url}/${accountId}/branding`, {
      branding: payload,
    });
  }
}

export default new AccountBrandingAPI();
