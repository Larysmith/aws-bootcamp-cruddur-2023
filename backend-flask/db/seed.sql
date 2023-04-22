-- this file was manually created (because we might auto generate it in future)
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('lary smith','ayinla.olanrewaju@gmail.com' , 'lary' ,'MOCK'),
  ('azeez yusuf','olanrewaju_yusuf@yahoo.com' , 'azeez' ,'MOCK'),
  ('mirah yusuf','my@test.pro' , 'mirah' ,'0f135149-48c2-4af7-a14b-872288005135');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'larymock' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )
