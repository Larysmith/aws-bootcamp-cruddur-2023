-- this file was manually created (because we might auto generate it in future)
INSERT INTO public.users (display_name, email, handle, cognito_user_id)
VALUES
  ('lary smith','ls@gmail.com' , 'larymock' ,'MOCK'),
  ('azeez yusuf','ay@test.co' , 'azeezmock' ,'MOCK'),
  ('mirah yusuf','my@test.pro' , 'mirahmock' ,'MOCK');

INSERT INTO public.activities (user_uuid, message, expires_at)
VALUES
  (
    (SELECT uuid from public.users WHERE users.handle = 'larymock' LIMIT 1),
    'This was imported as seed data!',
    current_timestamp + interval '10 day'
  )
