ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;


ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id);

-- pass
