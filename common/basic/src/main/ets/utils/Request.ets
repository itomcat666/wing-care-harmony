import { Log } from '@abner/log';
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig, AxiosRequestConfig } from '@ohos/axios'
import { userStore } from './Auth';

// 创建 axios 实例
export const instance = axios.create({
  baseURL: 'https://zhyl-harmony.itheima.net', // 基地址
  timeout: 5000 // 限制响应时间，ms
})

// 添加请求拦截器
instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
  // 对请求数据做点什么
  Log.info(`1-请求配置${config.method!}-${config.url}:${JSON.stringify(config.params || config.data)}`)
  // 练习使用
  // config.headers.Authorization = 'eyJhbGciOiJIUzI1NiJ9.eyJjdXJyZW50VXNlciI6IntcInVzZXJuYW1lXCI6XCJobHpnQHFxLmNvbVwiLFwicGFzc3dvcmRcIjpcIlwiLFwibmlja05hbWVcIjpcIuaKpOeQhue7hOS4u-euoVwiLFwiZW1haWxcIjpcImhsemdAcXEuY29tXCIsXCJyZWFsTmFtZVwiOlwi5oqk55CG57uE5Li7566hXCIsXCJtb2JpbGVcIjpcIlwiLFwic2V4XCI6XCJcIixcImRlcHROb1wiOlwiMTAwMDAxMDA1MDAwMDAwXCIsXCJwb3N0Tm9cIjpcIjEwMDAwMTAwNTAwMjAwMFwiLFwiaWRcIjoxNjY4NTIyMjgwODUxOTUxNjE3LFwiY3JlYXRlVGltZVwiOjE2OTU3MTAwOTcwMDAsXCJ1cGRhdGVUaW1lXCI6MTY5NTcxMDA5NzAwMCxcImNyZWF0ZUJ5XCI6MTY3MTQwMzI1NjUxOTA3ODEzOH0iLCJleHAiOjE0NjY0ODUzMzkyfQ.AwoGeu-mp0QSSsQnDOhQluAPdbFM7Ygll86fk6l3DIA'
  const store = userStore.getUser()
  if (store.token) {
    config.headers.Authorization = store.token
  }
  return config;
}, (error: AxiosError) => {
  // 对请求错误做些什么
  Log.error('3-http请求错误：' + JSON.stringify(error))
  return Promise.reject(error);
});


// 添加响应拦截器
instance.interceptors.response.use((response: AxiosResponse) => {
  // 对响应数据做点什么
  // response.data.code 存在且不为 200 时，返回错误结果
  if (response.data?.code && response.data.code !== 200) {
    AlertDialog.show({
      message: response.data?.msg
    })
    Log.error('3-code响应错误：' + JSON.stringify(response.data))
    return Promise.reject(response.data)
  }
  Log.warn('2-响应成功结果：' + JSON.stringify(response.data))
  // 简化数据返回
  return response.data?.data;
}, (error: AxiosError) => {
  AlertDialog.show({ message: error.response?.status + '：' + error.message })
  Log.error('3-http响应错误：' + JSON.stringify(error))
  // 对响应错误做点什么
  return Promise.reject(error);
});

// 封装请求方法，使用泛型约束返回值类型
export function request<DataModel = null, DataParams = null>(config: AxiosRequestConfig<DataParams>) {
  return instance<null, DataModel>(config)
}