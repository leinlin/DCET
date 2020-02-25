﻿using System;

namespace DCET
{
	public interface IDeserializeSystem
	{
		Type Type();
		void Run(object o);
	}

	/// <summary>
	/// 反序列化后执行的System
	/// 要小心使用这个System，因为对象假如要保存到数据库，到dbserver也会进行反序列化，那么也会执行该System
	/// </summary>
	/// <typeparam name="T"></typeparam>
	public abstract class DeserializeSystem<T> : IDeserializeSystem
	{
		public void Run(object o)
		{
			Deserialize((T)o);
		}

		public Type Type()
		{
			return typeof(T);
		}

		public abstract void Deserialize(T self);
	}
}
