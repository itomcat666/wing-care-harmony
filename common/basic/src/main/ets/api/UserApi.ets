import dayjs from 'dayjs'
import { request } from '../utils/Request'
import { LoginParams } from '../viewmodel/UserModel'

/**
 * 华为手机号授权登录
 * @param data 登录参数
 * @returns token信息
 */
export function loginApi(data: LoginParams): Promise<string> {
  return request<string, LoginParams>({ url: '/employee/login', method: 'post', data })
}