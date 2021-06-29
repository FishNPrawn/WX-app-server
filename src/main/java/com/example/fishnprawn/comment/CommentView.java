package com.example.fishnprawn.comment;

import lombok.Data;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
public class CommentView {

    private int commentId;
    private String openId;
    private int goodId;
    private String name;
    private String content;
    private String image;
    private String comment_create_time;

    public void setAttributes(Comment comment){
        this.setCommentId(comment.getCommentId());
        this.setOpenId(comment.getOpenId());
        this.setGoodId(comment.getGoodId());
        this.setName(comment.getName());
        this.setContent(comment.getContent());
        this.setImage(comment.getImage());
        this.setComment_create_time(comment.getComment_create_time());
    }
}
