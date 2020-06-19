package com.dovile.organizer.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.dovile.organizer.entities.Task;

public interface TaskRepository extends JpaRepository<Task, Integer> {
	
    @Query(name = "Task.findUserID")
   List<Task> findUserID (@Param("id") Integer id);
    
    @Query(name = "Task.findUserIDAndFilter")
    List<Task> findUserIDAndFilter (@Param("id") Integer id, @Param("filter") String filter);
    
    @Query(name = "Task.findUserIDAndDate")
    List<Task> findUserIDAndDate (@Param("id") Integer id, @Param("date") String date);
    
    @Query(name = "Task.findUserIDNotID")
    List<Task> findUserIDNotID (@Param("id") Integer id, @Param("tid") Integer tid);

}
