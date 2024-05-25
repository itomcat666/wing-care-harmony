import { Log } from '@abner/log';
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'

const instance = axios.create({
  baseURL: 'https://zhyl-harmony.itheima.net',
  timeout: 5000
})

// 添加请求拦截器
axios.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  // 对请求数据做点什么
  Log.info(`1-请求配置${config.method!}-${config.url}:${JSON.stringify(config.params || config.data)}`)
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  return Promise.reject(error);
});


// 添加响应拦截器
axios.interceptors.response.use((response: AxiosResponse) => {
  // 对响应数据做点什么
  // response.data.code 存在且不为 200 时，返回错误结果
  if (response.data?.code && response.data.code !== 200) {
    AlertDialog.show({
      message: response.data?.msg
    })
    Log.error('3-code请求错误：' + JSON.stringify(response.data))
    return Promise.reject(response.data)
  }
  Log.warn('2-请求成功结果：' + JSON.stringify(response.data))
  // 简化数据返回
  return response.data?.data;
}, (error: AxiosError) => {
  AlertDialog.show({ message: error.response?.status + '：' + error.message })
  Log.error('3-http请求错误：' + JSON.stringify(error))
  // 对响应错误做点什么
  return Promise.reject(error);
});

export { instance }