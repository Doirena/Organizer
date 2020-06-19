package com.dovile.organizer.entities;

import java.util.Date;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "task")
@NamedQueries({
    @NamedQuery(name = "Task.findUserID", query = "SELECT t FROM Task t join t.user u WHERE (u.id = :id) order by t.start_date asc"),
    @NamedQuery(name = "Task.findUserIDAndFilter", query = "SELECT t FROM Task t join t.user u WHERE (u.id = :id) and t.start_date like concat('%', :filter, '%')"),
    @NamedQuery(name = "Task.findUserIDAndDate", query = "SELECT t FROM Task t join t.user u WHERE (u.id = :id) and t.start_date like concat('%', :date, '%')"),
	@NamedQuery(name = "Task.findUserIDNotID", query = "SELECT t FROM Task t join t.user u WHERE (u.id = :id) and t.id <> :tid")})

public class Task {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	@Temporal(TemporalType.TIMESTAMP)
	private Date start_date;
	@Temporal(TemporalType.TIMESTAMP)
	private Date finish_date;
	private String name;
	private String description;
	@JoinColumn(name = "user_id", referencedColumnName = "id")
	@ManyToOne(optional = false)
	private User user;

	public Task() {
	}

	public Task(Integer id) {
		this.id = id;
	}

	public Task(Integer id, Date start_date, Date finish_date, String name) {
		this.id = id;
		this.start_date = start_date;
		this.finish_date = finish_date;
		this.name = name;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getFinish_date() {
		return finish_date;
	}

	public void setFinish_date(Date finish_date) {
		this.finish_date = finish_date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
