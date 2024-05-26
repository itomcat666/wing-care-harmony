import { request } from '@hm/basic/Index'
import { MessageCountData } from '../model/HomeModel'

/**
 * 统计当前护理员的未读消息数量
 * @returns 未读消息数量
 */
export function getMessageCountApi(): Promise<MessageCountData> {
  return request<MessageCountData>({ url: '/employee/message/statisticsUnreadByType' })
}