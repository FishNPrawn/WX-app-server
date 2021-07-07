package com.example.fishnprawn.comment;

import com.example.fishnprawn.exception.NotFoundException;
import com.example.fishnprawn.exception.ServiceException;
import com.example.fishnprawn.exception.ServiceValidationException;
import com.example.fishnprawn.services.Services;
import com.example.fishnprawn.validation.GoodArgumentValidation;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
@Transactional
public class CommentServices implements Services<Comment> {

    @Autowired
    private GoodArgumentValidation goodArgumentValidation;

    @Autowired
    private CommentDao commentDao;

    @Override
    public Comment addOne(Comment anObj) {
        return null;
    }

    @Override
    public Comment getById(Integer anId) {
        return null;
    }

    @Override
    public List<Comment> getAll(Map<String, String> filter) {

        if(!goodArgumentValidation.checkFilter(filter)){
            throw new ServiceValidationException("Illegal field in filter");
        }
        try {
            Comment comment = new Comment();
            comment.setGoodId(Integer.parseInt(filter.get("filter")));

            ExampleMatcher customExampleMatcher = ExampleMatcher.matchingAny()
                    .withMatcher("goodId", ExampleMatcher.GenericPropertyMatchers.exact());

            Example<Comment> commentExample = Example.of(comment, customExampleMatcher);
            return commentDao.findAll(commentExample);

        }catch (RuntimeException e){
            throw new ServiceException(e.getMessage());
        }
    }

    @Override
    public Comment updateById(Integer anId, Comment anObj) {
        return null;
    }

    @Override
    public Comment updateAttrById(Integer anId, Map<String, String> anUpdateMap) {
        return null;
    }

    @Override
    public Comment save(Comment anObj) {
        return null;
    }

    @Override
    public Comment deleteById(Integer id) {

        if(!commentDao.existsById(id)){
            throw new NotFoundException();
        }

        try {
            Comment comment = commentDao.findById(id).orElse(null);
            commentDao.deleteById(id);
            return comment;
        }catch(RuntimeException e){
            //Exception from repository
            throw new ServiceException(e.getMessage());
        }

    }
}
