package com.chinatour.entity;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by XuXuebin on 2014/7/9.
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Message extends BaseEntity {
    /**
     * 标题
     */
    private String title;

    /**
     * 内容
     */
    private String content;

    /**
     * ip
     */
    private String ip;

    /**
     * 是否为草稿
     */
    private Boolean isDraft;

    /**
     * 发件人已读
     */
    private Boolean senderRead;

    /**
     * 收件人已读
     */
    private Boolean receiverRead;

    /**
     * 发件人删除
     */
    private Boolean senderDelete;

    /**
     * 收件人删除
     */
    private Boolean receiverDelete;

    /**
     * 发件人
     */
    private Member sender;

    /**
     * 收件人
     */
    private Member receiver;

    /**
     * 原消息
     */
    private Message forMessage;

    /**
     * 回复消息
     */
    private Set<Message> replyMessages = new HashSet<Message>();
}
