import discord
from discord.ext import commands

intents = discord.Intents.default()
intents.members = True

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f'Bot {bot.user} is ready.')

# Beispiel-Kommando
@bot.command()
async def ping(ctx):
    await ctx.send('Pong!')

# Füge hier weitere Befehle hinzu...

bot.run('MTI3NTgxNDU2MjkxODAzOTY1NQ.GQ7UnO.PrzclJ7Rh6achjgGTpm02WmhE8yqnFR3PxXKD8')
