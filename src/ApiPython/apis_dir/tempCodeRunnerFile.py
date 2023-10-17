    cursor.execute(f"SELECT SCOPE_IDENTITY() AS last_insert_id")
    last_id = cursor.fetchone().last_insert_id
    print(f"o último id inserido foi o {last_id}")
    new_std.update({'id_aluno': last_id})