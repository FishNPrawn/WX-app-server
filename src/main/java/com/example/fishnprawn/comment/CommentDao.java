package com.example.fishnprawn.comment;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CommentDao extends JpaRepository<Comment, Integer> {
}
